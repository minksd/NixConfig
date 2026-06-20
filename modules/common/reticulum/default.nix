{
  config,
  lib,
  pkgs,
  ...
}:
let
  interfaceType = with lib.types; (submodule {
    options = {
      enabled = lib.mkOption {
        type = bool;
        default = false;
        description = "Whether or not to enable the given interface";
        example = true;
      };
      name = lib.mkOption {
        type = str;
        default = "Interface";
        example = "My Interface";
      };
      type = lib.mkOption {
        type = enum [
            "AutoInterface"
            "BackboneInterface"
            "TCPServerInterface"
            "TCPClientInterface"
            "UDPInterface"
            "I2PInterface"
            "RNodeLoRaInterface"
            "RNodeMultiInterface"
            "SerialInterface"
            "PipeInterface"
            "KISSInterface"
            "AX25KISSInterface"
            "CustomInterface"
          ];
      };
      additionalSettings = lib.mkOption {
        type = attrsOf (oneOf [
          str
          bool
          (listOf str)
        ]);
        default = {};
        example = {
          group_id = "reticulum";
          multicast_address_type = "permanent";
          devices = ["wlan0" "eth1"];
          ignored_devices = ["tun0" "eth0"];
        };
      };
    };
  });
  
  interfacesType = (lib.types.listOf interfaceType);
in {
  options = {
    services.reticulum = {
      enable = lib.mkEnableOption {
        description = "Whether or not to enable the reticulum networking stack on this system";
      };
      configFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        example = /path/to/reticulum/config;
      };
      nixConfig = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
        settings = lib.mkOption {
          type = lib.types.attrsOf (lib.types.oneOf [
            lib.types.str
            lib.types.number
            lib.types.bool
            lib.types.path
          ]);
          default = {
          };
          example = {
            enable_transport = false;
            share_instance = true;
            instance_name = "default";
          };
        };
        logging = {
          loglevel = lib.mkOption {
            type = lib.types.numbers.between 0 7;
            default = 4;
            example = 0;
          };
        };
        interfaces = lib.mkOption {
          type = interfacesType;
          default = [
            {
              name = "DefaultInterface";
              type = "AutoInterface";
              enabled = true;
            }
          ];
        };
      };
    };
  };

  config = let
    utils = import ./utils.nix lib;
    cfg = config.services.reticulum;
  in
    lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = ((cfg.nixConfig.enable && cfg.configFile == null) || (!cfg.nixConfig.enable && cfg.configFile != null));
          message = ''
                  services.reticulum: One of either (nixConfig.enable == true) OR (configFile != null) must be true.
                    '';
        }
      ];
      environment.systemPackages = [
        (pkgs.symlinkJoin {
          name = "reticulum-wrapped";
          paths = [ pkgs.rns ];
          buildInputs = [ pkgs.makeBinaryWrapper ];
          postBuild = ''
    for bin in $out/bin/*; do
      # Skip wrapping if it's not an executable file
      [ -f "$bin" ] && [ -x "$bin" ] || continue
      
      # Rename the original binary and create a wrapper that appends the config flag
      wrapProgram "$bin" --add-flags "--config /var/lib/reticulum"
    done
  '';
        })
      ];
      environment.etc."reticulum/config" = with utils; {
        enable = true;
        text = let
          reticulumList = (lib.attrsToList cfg.nixConfig.settings);
          loggingList = (lib.attrsToList cfg.nixConfig.logging);
          interfacesList = cfg.nixConfig.interfaces;
        in if (cfg.configFile == null)
           then
             lib.concatStringsSep "\n" [
               (lib.foldl retFold "[reticulum]" reticulumList)
               (lib.foldl loggingFold "[logging]" loggingList)
               (lib.foldl interfacesFold "[interfaces]" interfacesList)
             ]
           else
             (builtins.readFile cfg.configFile);
      };
      systemd.services.reticulum = let
      in {
        enable = true;
        description = "Reticulum Network Stack Daemon";
        restartIfChanged = true;
        serviceConfig = {
          Type="simple";
          Restart="always";
          RestartSec=3;
          #DynamicUser= true;
          StateDirectory = "reticulum";
          RuntimeDirectory = "reticulum";
          ExecStart="${pkgs.rns}/bin/rnsd --service --config /var/lib/reticulum";
        };
        preStart = ''
      cp /etc/reticulum/config /var/lib/reticulum/config
      chmod 444 /var/lib/reticulum/config
  '';
        after = ["multi-user.target"];
        wantedBy = ["multi-user.target"];
      };
    };
}

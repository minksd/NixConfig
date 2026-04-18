{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    minecraft = {
      enable = lib.mkEnableOption {
        description = "Enable Olivia MC server.";
      };
    };
  };

  config = lib.mkIf config.minecraft.enable {
    # Minecraft server settings
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      managementSystem.systemd-socket.enable = true;
      servers.fabricServer = {
        enable = true;

        jvmOpts = "-Xms2048M -Xmx4096M";
        # Specify the custom minecraft server package
        package = pkgs.vanillaServers.vanilla;

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (
            builtins.attrValues {
              #mods go here like this.
              #              Fabric-API = pkgs.fetchurl {
              #               url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/dQ3p80zK/fabric-api-0.138.3%2B1.21.10.jar";
              #               sha256 = "sha256-rCB1kEGet1BZqpn+FjliQEHB1v0Ii6Fudi5dfs9jOVM=";
              #             };
            }
          );
        };
      };
      servers.chosenSeed = {
        enable = true;

        jvmOpts = "-Xms2048M -Xmx4096M";
        # Specify the custom minecraft server package
        package = pkgs.minecraftServers.vanilla-1_21_11.override {
          jre_headless = pkgs.jdk21_headless;
        };

        serverProperties = {
          server-port = 51000;
          level-seed = -2950580325944898288;
        };
      };
    };
  };
}

{
  inputs,
  ...
}:
{
  flake.modules.nixos.wireguard = {config, lib, ...}: {
    imports = [
      inputs.self.modules.generic.constants
      inputs.self.modules.nixos.age
    ];
    networking = {
      wg-quick.interfaces = {
        spotColorSite02 = {
          privateKeyFile = config.age.secrets.wg-spot-color-site-02.path;
          address = ["10.0.245.6/32"];
          peers = [
            {
              publicKey = builtins.readFile ./wg-spot-color-site-02.pub;
              endpoint = "site2.welikesto.party:23645";
              allowedIPs = [ "10.0.245.0/24" "10.0.1.0/24" "10.0.0.1/24"];
            }
          ];
        };
      };
      firewall.allowedUDPPorts = with config.networking.wg-quick.interfaces; [
        spotColorSite02.listenPort
      ];
    };
    };
  }

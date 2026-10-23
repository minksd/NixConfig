{
  config,
  self,
  ...
}:
{
  flake.modules.nixos.wireguard = {
    services.wg-quick.interfaces = {
      personalDevices = {
        address = [
          "fd31:bf08:57cb::2/128"
          "192.168.2.2/32"
        ];
        dns = [
          "127.0.0.1"
          "::1"
        ];
        privateKeyFile = config.age.secrets.wg-minksdLaptop.path;
        peers = [
          {
            # minksdHome
            publicKey = builtins.readFile ./wg-minksdHome.pub;
            allowedIPs = [
              "fd31:bf08:57cb::1/128"
              "192.168.2.1/32"
            ];
            endpoint = "${config.constants.wireguard.url}";
          }
        ];
      };
    };
  };
}

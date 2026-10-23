{
  inputs,
...
}:
{
  flake.modules.nixos._minksdHome = {config, ...}:{
    imports = [
      inputs.self.modules.nixos.wireguard
      inputs.self.modules.nixos.age
    ];
    networking.wg-quick.interfaces = {
      personalDevices = {
        address = [
          "fd31:bf08:57cb::1/128"
          "192.168.2.1/32"
        ];
        listenPort = 51820;
        dns = [
          "127.0.0.1"
          "::1"
        ];
        privateKeyFile = config.age.secrets.wg-minksdHome.path;
        peers = [
          {
            # minksdLaptop
            publicKey = config.constants.wireguard.pubKeys.minksdLaptop;
            allowedIPs = [
              "192.168.2.2/32"
              "fd31:bf08:57cb::2/128"
            ];
          }
        ];
      };
    };
  };
}

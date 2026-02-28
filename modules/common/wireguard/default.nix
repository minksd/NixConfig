{config, lib, ...}:{
  config = {
    networking.wg-quick.interfaces = lib.mkMerge [
      #Configuration for minksdHome
      (lib.mkIf (config.networking.hostName == "minksdHome") {
        wg0 = {
          address = [ 
            "fd31:bf08:57cb::1/128"
            "192.168.2.1/32"
          ];
          listenPort = 51820;
          dns = [ "127.0.0.1" "::1" ];
          privateKeyFile = config.age.secrets.wg-minksdHome.path;
          peers = [
            {
              # minksdLaptop
              publicKey = builtins.readFile ./wg-minksdLaptop.pub;
              allowedIPs = [
                "192.168.2.2/32"
                "fd31:bf08:57cb::2/128"
              ];
            }
          ];
        };
      })
      #Configuration for minksdLaptop
      (lib.mkIf (config.networking.hostName == "minksdLaptop") {
        wg0 = {
          address = [ 
            "fd31:bf08:57cb::2/128"
            "192.168.2.2/32"
          ];
          dns = [ "127.0.0.1" "::1" ];
          privateKeyFile = config.age.secrets.wg-minksdLaptop.path;
          peers = [
            {
              # minksdHome
              publicKey = builtins.readFile ./wg-minksdHome.pub;
              allowedIPs = [
                "fd31:bf08:57cb::1/128"
                "192.168.2.1/32"
              ];
              endpoint = "minksdHome.minksulivarri.org:51820";
            }
          ];
        };
      })
    ];
  };
}

{config, lib, ...}:{
  config = {
    networking.wg-quick.interfaces = lib.mkMerge [
      (lib.mkIf (config.networking.hostname == "minksdHome") {
        wg0 = {
          address = [ 
            "fd31:bf08:57cb::1/128"
            "192.168.26.1/32"
          ];
          dns = [ "127.0.0.1" "::1" ];
          privateKeyFile = config.age.secrets.wg-minksdHome.path;
          peers = [
            {
              # minksdWSL
              publicKey = ;
              allowedIPs = [
                "fd31:bf08:57cb::2/128"
                "192.168.26.2/32"
              ];
              endpoint = "192.168.1.56:51820";
            }
          ];
        };
      })
      (lib.mkIf (config.networking.hostname == "minksdWSL") {
        wg0 = {
          address = [ 
            "fd31:bf08:57cb::8/128"
            "192.168.26.8/32"
          ];
          # use dnscrypt, or proxy dns as described above
          dns = [ "127.0.0.1" ];
          privateKeyFile = config.age.secrets.wg-key-laptop.path;
          peers = [
            {
              # bt wg conf
              publicKey ="";
              allowedIPs = [
                "fd31:bf08:57cb::8/128"
                "192.168.26.8/32"
              ];
              endpoint = "192.168.1.56:51820";
            }
          ];
        };
      })
    ];
  };
}

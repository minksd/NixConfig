{
  ...
}:
{
  flake.modules.generic.secrets = {lib, ...}:{
    options.secrets = {
      ssl = lib.mkOption {
        type = lib.types.attrsOf lib.types.path;
        default = {
          vaultwarden = ./vaultwarden-ssl-key.age;
        };
        readOnly = true;
      };
      password = lib.mkOption {
        type = lib.types.attrsOf lib.types.path;
        default = {
          minksd = ./minksdPass.age;
        };
        readOnly = true;
      };
      api = lib.mkOption {
        type = lib.types.attrsOf lib.types.path;
        default = {
          cloudflare = ./minksdHome-ddns.age;
        };
        readOnly = true;
      };
      wireguard = lib.mkOption {
        type = lib.types.attrsOf lib.types.path;
        default = {
          minksdHome = ./wg-minksdHome.age;
          minksdLaptop = ./wg-minksdLaptop.age;
          spot-color-site-02 = ./wg-spot-color-site-02.age;
        };
      };
    };
  };
}

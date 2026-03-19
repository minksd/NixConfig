{
  config,
  lib,
  ...
}:
{
  options = {
    ddns = {
      enable = lib.mkEnableOption {
        default = lib.mkFalse;
        descripition = "Send ddns updates to cloudflare";
      };
    };
  };

  config = lib.mkIf (config.ddns.enable == true) {
    services.cloudflare-ddns = {
      enable = true;
      credentialsFile = config.age.secrets.minksdHome-ddns.path;
      domains = [
        "minksdHome.minksulivarri.org"
      ];
      proxied = "true";
    };
  };
}

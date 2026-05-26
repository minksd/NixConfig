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

  config = lib.mkIf (config.ddns.enable == true && config.networking.hostName == "minksdHome") {
    services.cloudflare-ddns = {
      enable = true;
      credentialsFile = config.age.secrets.home_minksd-ddns.path;
      domains = [
        "home.minksd.us"
      ];
      proxied = "true";
    };
  };
}

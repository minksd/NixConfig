{
  lib,
  config,
  pkgs,
  ...
}:
{

  config = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        X11Forwarding = true;
      };
    };

  };

}

{
 config,
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
    home-manager.users.${config.user} = {
      programs.ssh = {
        enable = true;
        settings."*" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/master-%C";
          ControlPersist = "10m";
        };
      };
    };
  };

}

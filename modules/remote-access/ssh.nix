{
  config,
  ...
}:
{
  flake.modules.nixos.ssh = {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = config.services.openssh.ports;
    };
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        X11Forwarding = true;
      };
    };
  };
  flake.modules.homeManager.minksd = {
    home-manager.users.minksd = {
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

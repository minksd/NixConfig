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
  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        ForwardAgent = false;
        AddKeysToAgent = "yes";
        Compression = true;
        
        ControlMaster = "auto";
        ControlPath = "~/.ssh/master-%C";
        ControlPersist = "10m";
      };
    };
  };
}

{
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos.minksd = {config, lib, ...}: {
    imports = with inputs.self.modules.nixos; [
      base-user
      age
    ];
    users.users.minksd = {

      # Create a home directory for human user
      isNormalUser = true;

      hashedPasswordFile = config.age.secrets.minksdPass.path;
      extraGroups = [
        "wheel" # Sudo privileges
        "docker" # Allow access to the docker daemon
        "plugdev" # Added to allow probe-rs udev rules"
      ];
    };
    nix.settings.trusted-users = [ "minksd" ];
    home-manager.users.minksd = {
      imports = [
        inputs.self.modules.homeManager.minksd
      ];
    };
  };
  flake.modules.homeManager.minksd = {
    imports = with inputs.self.modules.homeManager; [
    ];
    home = lib.mkDefault {
      stateVersion = "24.05";
      homeDirectory = "/home/minksd/";
      username = "minksd";
    };
    xdg = {

      # Allow Nix to manage the default applications list
      mimeApps.enable = true;

      # Set directories for application defaults
      userDirs = {
        enable = true;
        setSessionVariables = false;
        createDirectories = true;
        documents = "$HOME/documents";
        download = "$HOME/downloads";
      };
    };
  };
}

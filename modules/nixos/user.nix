{
  config,
  pkgs,
  lib,
  globals,
  inputs,
  ...
}:
{

  config = {
    users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJwTtdUEANYjL0U/k+AQNYKs2ZmiRMUVD4IXPVZC9oi9 root@minksdLaptop
"];
    
    # Allows us to declaritively set password if false
    users.mutableUsers = false;

    users.users.minksd = {

      # Create a home directory for human user
      isNormalUser = true;

      hashedPasswordFile = config.age.secrets.minksdPass.path;
      group = "minksd";
      extraGroups = [
        "wheel" # Sudo privileges
        "docker" # Allow access to the docker daemon
      ];
    };
    users.groups.minksd = { };
    nix.settings.trusted-users = ["minksd"];

    home-manager.users."${config.user}" = {

      imports = [
        inputs.agenix.homeManagerModules.default
      ];

      age.secrets.minksdU2F.file = "${globals.secretsDir}/minksdU2F.age";
      age.secrets.minksdU2F.path = "/home/minksd/.config/Yubico/u2f_keys";

      xdg = {

        # Allow Nix to manage the default applications list
        mimeApps.enable = true;

        # Set directories for application defaults
        userDirs = {
          enable = true;
          createDirectories = true;
          documents = "$HOME/documents";
          download = config.userDirs.download;
        };
      };
    };
  };
}

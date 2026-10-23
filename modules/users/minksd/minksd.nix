{
  inputs,
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
  };
  flake.modules.homeManager.minksd = {lib, ...}: {
    home-manager.users.minksd = lib.mkMerge [
      inputs.self.modules.homeManager.minksd
      {
        home.stateVersion = "24.05";
        xdg = {

          # Allow Nix to manage the default applications list
          mimeApps.enable = true;

          # Set directories for application defaults
          userDirs = {
            enable = true;
            createDirectories = true;
            documents = "$HOME/documents";
            downloads = "$HOME/downloads";
          };
        };
      }
    ];

  };
}

{
  inputs,
  ...
}:
{
  flake.modules.nixos.programs-base = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      git
      tuned
      nh
      zsh
      chrony
    ];
    environment.systemPackages = with pkgs; [
      emacs
    ];
    programs = {
      direnv.enable = true;
    };
    
    virtualisation = {
      podman.enable = true;
      docker.enable = true;
    };

  };
  flake.modules.homeManager.programs-base = {
    imports = with inputs.self.modules.homeManager; [
      emacs
      zsh
    ];
  };
}

{
  flake.modules.homeManager.emacs-development-envrc = {pkgs, lib, ...}: {
    programs.emacs = {
      extraConfig = lib.mkBefore ''
        (envrc-global-mode)
      '';
      extraPackages = epkgs: with epkgs; [
        envrc
      ];
    };
    home.packages = [ pkgs.direnv ];
  };
}

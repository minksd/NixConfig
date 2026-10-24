{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development-nix-mode = {pkgs, ...}: {
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        nix-mode
      ];
      extraConfig = ''
        (use-package nix-mode)
      '';
    };
    home.packages = [
      pkgs.nixd
    ];
    lspModeHooks = "(nix-mode . lsp)";
  };
}

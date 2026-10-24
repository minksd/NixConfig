{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development = {lib, ...}: {
    _file = ./development.nix;
    imports = with inputs.self.modules.homeManager; [
      emacs
      emacs-development-envrc
      emacs-development-lsp-mode
      emacs-development-nix-mode
    ];
    options = {
      lspModeHooks = lib.mkOption {
        type = lib.types.lines;
        default = "";
        example = ''
          (nix-mode . lsp)
        '';
      };
    };
    config = { 
      programs.emacs = {
        extraPackages = epkgs: with epkgs; [
          company
          flycheck
        ];
        extraConfig = ''
        ;;company-mode
        (use-package company)
        (add-hook 'prog-mode-hook 'company-mode)

        ;;Adds flycheck for inline syntax checking
        (use-package flycheck)
        (add-hook 'prog-mode-hook 'flycheck-mode)
      '';
      };

    };
  };
}

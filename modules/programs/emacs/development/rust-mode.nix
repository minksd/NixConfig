{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development-rust-mode = {pkgs, ...}: {
    lspModeHooks = "(rust-mode . lsp-deferred)";

    programs.emacs = {
      extraConfig = ''
        ;;Rust Configuration
        (use-package rust-mode)
        (add-hook 'rust-mode-hook 'envrc-mode)
        ;;Formats file when saved
        (setq rust-format-on-save t)
      '';
      extraPackages = epkgs: with epkgs; [
        rust-mode
      ];
    };
  };
}

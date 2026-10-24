{
  inputs,
  ...
}:{
  flake.modules.homeManager.emacs-development-lsp-mode = {config, ...}: {
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        lsp-mode
      ];
      extraConfig = ''
      ;;lsp-mode
      (use-package lsp-mode
        :init
          ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
          (setq lsp-keymap-prefix "C-c l")
        :hook (
          ${config.lspModeHooks})
        :commands lsp)
    '';
    };
  };
}

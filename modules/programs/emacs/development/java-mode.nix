{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development-java-mode = {pkgs, ...}: {
    lspModeHooks = "(java-mode . lsp)";

    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        lsp-java
      ];
      extraConfig = ''
        ;;Java Configuration
        (use-package lsp-java
          :config (setq lsp-java-java-path "${pkgs.jdk}/bin/java"))
    '';
    };
    home.packages = with pkgs; [
      jdt-language-server
    ];
  };
}

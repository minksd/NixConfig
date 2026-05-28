{ config, pkgs, ... }:
{
  config = {
    environment.systemPackages = [
    ];

    home-manager.users.${config.user} = {
      home.file.".emacs.d/rust.el".text = ''
        (use-package rust-mode)
        (add-hook 'rust-mode-hook 'lsp)
        ;;Formats file when saved
        (setq rust-format-on-save t)
      '';
    };
  };

}

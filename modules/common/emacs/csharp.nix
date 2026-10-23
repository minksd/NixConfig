{
  config,
  ...
}:
{
  config = {
    home-manager.users.${config.user} = {
      home.file.".emacs.d/rust.el".text = ''
        (use-package csharp-mode)
        (add-hook 'csharp-mode-hook 'lsp)
      '';
    };
  };
}

{
  inputs,
  ...
}:
{
  flake.modules.nixos.emacs = {pkgs, lib, config, ...}: {
    environment = {
      systemPackages = with pkgs; [
        emacs
      ];
      variables = { EDITOR = "emacs -nw"; VISUAL = "emacs -nw"; };
    };
  };
  flake.modules.homeManager.emacs = {lib, ...}: {
    services.emacs = {
      enable = true;
      startWithUserSession = true;
    };
    programs.emacs = {
      enable = true;
      extraConfig = ''
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tsdh-dark)))

;;------Setting variables------

(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Disable the startup screen
(setq inhibit-startup-screen t)
;;Move all backups to ~/.ebackups
(setq backup-directory-alist '(("." . "~/.backups")))
;;Delete autosave files after buffer is closed
(setq kill-buffer-delete-auto-save-files 1)
(setq delete-auto-save-files t)
'';
    };
  };
  
}

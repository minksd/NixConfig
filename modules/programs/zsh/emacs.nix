{
  flake.modules.homeManager.zsh-emacs = {
    programs.zsh.oh-my-zsh.extraConfig = ''alias emacs="emacsclient"'';
  };
}

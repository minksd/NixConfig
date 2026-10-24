{
  inputs,
  ...
}: {
  flake.modules.nixos.zsh = {pkgs, ...}: {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
  
  flake.modules.homeManager.zsh = {config, pkgs, ...}: {
    imports = with inputs.self.modules.homeManager; [
      zsh-emacs
      zsh-run0
    ];
    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        oh-my-zsh.enable = true;
        oh-my-zsh.extraConfig = ''

            export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"

            source $ZSH/oh-my-zsh.sh

            #So that connections like TRAMP dont have to deal with ANSI BS
            if [[ "$TERM" == "dumb" ]]; then
               PS1='$ '
            fi

            ZSH_THEME="amuse"
          '';
      };
    };
  };
}

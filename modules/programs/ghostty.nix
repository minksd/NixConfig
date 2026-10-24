{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      systemd.enable = true;
      settings = {
        font-size = 10;
        font-family = [
          "Cascadia Code NF"
          "M+1Code Nerd Font Mono"
        ];
        font-style = "Regular";
        theme = "Japanesque";
      };
    };
  };
}

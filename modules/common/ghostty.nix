{ lib, config, ... }:

{
  options.ghostty.enable = lib.mkEnableOption {
    default = false;
    description = "Ghostty is a terminal emulator that differentiates itself by being fast, feature-rich, and native.";
  };
  config =
    let
      cfg = config.ghostty;
    in
    lib.mkIf (cfg.enable == true) {
      home-manager.users.${config.user} = {
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
    };
}

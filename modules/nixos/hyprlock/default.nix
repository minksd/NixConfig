{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options.hyprlock.enable = lib.mkEnableOption {
    default = false;
  };

  config = lib.mkIf (config.hyprlock.enable == true) {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        hyprlock
        ;
    };

    home-manager.users."${config.user}" = {
      home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
      home.file.".config/hypr/wallpapers/" = {
        recursive = true;
        source = "${inputs.wallpapers}/8k Japan/";
      };
    };
  };

}

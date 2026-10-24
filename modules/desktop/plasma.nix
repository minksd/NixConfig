{
  inputs,
  ...
}: {
  flake.modules.nixos.desktop-plasma = {pkgs, lib, config, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${pkgs.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha-mauve";
      };
    };
    environment.systemPackages = with pkgs; [
      bibata-cursors
      fuzzel
      xwayland-satellite
      wl-clipboard
    ];
    environment.variables.NIXOS_OZONE_WL = "1";
  };
}

{
  inputs,
  ...
}:
{
  flake.modules.nixos.gui-system = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      base-system
      programs-gui
      desktop-plasma
    ];
    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        wlr.enable = true;
        extraPortals = builtins.attrValues {
          inherit (pkgs)
            xdg-desktop-portal
            xdg-desktop-portal-gnome
            xdg-desktop-portal-gtk
            xdg-desktop-portal-wlr
          ;

        };
      };
    };

    fonts.packages = builtins.attrValues {
      inherit (pkgs)
        cascadia-code
        ipaexfont
      ;
      inherit (pkgs.nerd-fonts)
        "m+"
      ;
    };
  };
  flake.modules.homeManager.gui-system = {
    imports = with inputs.self.modules.homeManager; [
      base-system
      programs-gui
    ];
  };
}

{
  flake.modules.nixos.steam = {pkgs, ...}: {
    environment.systemPackages = [ pkgs.mangohud ];
    hardware.steam-hardware.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };
    programs.gamescope.capSysNice = false;
    programs.gamemode.enable = true;
  };
}

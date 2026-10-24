{
  inputs,
  ...
}: {
  flake.modules.nixos.programs-gui = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      steam
      discord
    ];

    programs = {
      droidcam.enable = true;
    };

    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };
    };
  };
  flake.modules.homeManager.programs-gui = {
    imports = with inputs.self.modules.homeManager; [
      discord
      firefox
      ghostty
    ];
  };
}

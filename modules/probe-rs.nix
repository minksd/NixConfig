{
  ...
}: {
  flake.modules.nixos.probe-rs = {pkgs,...}: {
    services.udev.packages = [
      pkgs.probe-rs-tools
    ];
  };
}

{
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos.minksdHome = {
    imports =
      with inputs.self.modules.nixos;
      [
        minksd
        gui-system

        i2pd
        cheapino
        probe-rs
      ];
    nixpkgs.hostPlatform = { system = "x86_64-linux"; };
    system.stateVersion = "24.04";
    networking.hostName = "minksdHome";

    nix.settings = {
      cores = 4;
      max-jobs = 3;
    };
  };
  flake.modules.homeManager.minksd = let
    stateVersion = "24.05";
  in {
    home = {inherit stateVersion;};
  };
}

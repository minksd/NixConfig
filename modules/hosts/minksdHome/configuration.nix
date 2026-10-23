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
      ];
  };
}

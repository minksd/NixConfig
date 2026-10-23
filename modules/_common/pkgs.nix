{
  inputs,
  system,
  lib,
  config,
  ...
}:

{
  self.modules.pkgs = import inputs.nixpkgs {
    inherit system;
  };
}

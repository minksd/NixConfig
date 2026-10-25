{
  inputs,
  ...
}:
{
  flake.modules.nixos.minksd = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}

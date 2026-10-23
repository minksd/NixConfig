{
  inputs,
  ...
}:
{
  flake.modules.homeManager.minksd = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}

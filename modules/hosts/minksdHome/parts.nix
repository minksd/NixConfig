{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.minksdHome = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos.minksdHome
    ];
  };
}

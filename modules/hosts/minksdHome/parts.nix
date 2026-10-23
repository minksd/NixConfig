{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.minksdHome = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos.minksdHome
      {
        nixpkgs.hostPlatform = { system = "x86_64-linux"; };
        system.stateVersion = "24.04";
      }
    ];
  };
}

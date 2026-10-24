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
  flake.homeConfigurations.minksd = inputs.home-manager.lib.homeManagerConfiguration {
    modules = with inputs.self.modules.homeManager; [
      minksd
    ];
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  };
}

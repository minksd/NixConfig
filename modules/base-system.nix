{
  withSystem,
  inputs,
  ...
}:
{
  perSystem = { system, config, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ ];
      config = {
        allowUnfree = true;
      };
    };
  };
  flake.modules.nixos.base-system = {config, ...}: {

    imports =
      with inputs.self.modules.nixos;
      with inputs.self.modules.generic;
      [
        root
        constants

        #inputs.nixpkgs.nixosModules.readOnlyPkgs
      ];
    nixpkgs.pkgs = import inputs.nixpkgs {
      system = config.nixpkgs.hostPlatform.system;
      overlays = [];
      config = {
        allowUnfree = true;
      };
    };
  };

}


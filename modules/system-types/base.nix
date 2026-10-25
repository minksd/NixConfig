{
  withSystem,
  inputs,
  ...
}:
{
  perSystem = { system, config, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
      ];
      config = {
        allowUnfree = true;
      };
    };
  };
  flake.modules.nixos.base-system = {pkgs, config, ...}: {

    imports =
      with inputs.self.modules.nixos;
      with inputs.self.modules.generic;
      [
        #Users
        root
        
        constants
        
        programs-base
        security-base
        #inputs.nixpkgs.nixosModules.readOnlyPkgs
      ];
    nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system
      (
        {pkgs, ...}:
        pkgs
      );
    i18n.defaultLocale = "en_US.UTF-8";

    networking.enableIPv6 = true;
    
    nix = {
      package = pkgs.lixPackageSets.stable.lix;
      distributedBuilds = true;
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
      };
    };
  };
  flake.modules.homeManager.base-system = {
    imports = with inputs.self.modules.homeManager; [
      programs-base
    ];
  };
}


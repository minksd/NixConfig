{
  inputs,
  withSystem,
  ...
}: {
  flake.modules.homeManager.minksd = {
    imports = with inputs.self.modules.homeManager; [
      gui-system
      emacs-development-all
    ];
  };
  flake.homeConfigurations.minksd = inputs.home-manager.lib.homeManagerConfiguration {
    modules = with inputs.self.modules.homeManager; [
      minksd
    ];
    pkgs = withSystem "x86_64-linux" ({pkgs, ...}: 
      pkgs
    );
  };

}

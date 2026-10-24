{
  inputs,
  ...
}: {
  flake.modules.homeManager.minksd = {
    imports = with inputs.self.modules.homeManager; [
      gui-system
      emacs-development-all
    ];
  };
}

{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development-all = {lib, ...}: {
    imports = with inputs.self.modules.homeManager; [
      emacs-development
      emacs-development-java-mode
      emacs-development-csharp-mode
      emacs-development-rust-mode
    ];
  };
}

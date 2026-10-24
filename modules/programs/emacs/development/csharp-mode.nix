{
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs-development-csharp-mode = {pkgs, ...}: {
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        #csharp-mode included in emacs, not needed
      ];
    };
    lspModeHooks = "(csharp-mode . lsp)";
    home.packages = with pkgs; [
      dotnet-sdk
    ];
  };
}

{
  inputs,
  ...
}: {
  flake-file.inputs = {
    ghostty.url = "github:ghostty-org/ghostty/4eb3088316b7a95af7a505aeb9a39dc8b93fcb8d";
  };
  flake.modules.homeManager.ghostty = {lib, config, ...}: {
    programs.ghostty = {
      enable = true;
      package = lib.warn "Using a patched ghostty, check if release with this patch is out. https://github.com/ghostty-org/ghostty/issues/14398" inputs.ghostty.packages.${config.nixpkgs.system}.ghostty;
      enableZshIntegration = true;
      systemd.enable = true;
      settings = {
        font-size = 10;
        font-family = [
          "Cascadia Code NF"
          "M+1Code Nerd Font Mono"
        ];
        font-style = "Regular";
        theme = "Japanesque";
      };
    };
  };
}

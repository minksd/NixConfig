# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:/denful/flake-file";
    flake-parts = {
      url = "github:/hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    home-manager = {
      url = "github:/nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:/denful/import-tree";
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs = {
        lix.follows = "lix";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    oisd = {
      url = "github:cbuijs/oisd";
      flake = false;
    };
  };
}

{
  imports,
  specialArgs,
  overlays,
  system,
  inputs,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit specialArgs;
  
  modules = imports ++ [
    ../modules/common
    ../modules/nixos
    (inputs.nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
    ({
      nixpkgs = {
        inherit overlays system;
        config = {
          allowUnfree = true;
        };
      };
      nix.settings = {
        extra-experimental-features = [
          "nix-command"
          "flakes"
        ];

        #Fixed hostname resolution of builders for some reason
        sandbox = false;
      };
      proxmoxLXC = {
        manageNetwork = false;
        privileged = false;
        manageHostName = true;
      };

      networking.hostName = "wheatly";
      services.fstrim.enable = false; # Let Proxmox host handle fstrim
      services.sshd.enable = true;

      git.enable = true;
      zsh.enable = true;
      nh.enable = true;
      emacs.enable = true;
      
      system.stateVersion = "26.04";
    })
  ];
}

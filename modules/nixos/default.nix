{ ... }:
{
  imports = [
    ./security
    ./flatpak.nix
    ./gfn.nix
    ./grayjay.nix
    ./lutris.nix
    ./steam.nix
    ./user.nix
    ./desktops
    ./minecraft.nix
    ./tuned.nix
    ./noctalia
    ./hyprlock
    ./vaultwarden
    ./dnscrypt-proxy.nix
  ];

}

{
  inputs,
  ...
}: {
  flake.modules.nixos.minksd.virtualisation.vmVariant = {lib, ...}: {
    users.users.minksd = {
      initialPassword = "password";
      hashedPasswordFile = lib.mkForce null;
    };
  };
}

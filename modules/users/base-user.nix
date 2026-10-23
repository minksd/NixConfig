{
  inputs,
  self,
  config,
  ...
}:
{
  flake.modules.nixos.base-user = {
    # Allows us to declaritively set password if false
    users.mutableUsers = false;

    users.groups.plugdev = {};
  };
}

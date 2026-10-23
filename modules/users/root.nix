{
  inputs,
  ...
}:
{
  flake.modules.nixos.root = {
    imports = with inputs.self.modules.nixos; [
      base-user
    ];
  };
}

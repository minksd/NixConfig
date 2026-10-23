{
  inputs,
  ...
}:
{
  flake.modules.nixos.gui-system = {
    imports = with inputs.self.modules.nixos; [
      base-system
    ];
  };
}

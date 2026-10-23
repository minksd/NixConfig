{
  inputs,
  ...
}:
{
  flake.modules.nixos.remote-access-minksdHome = {
    imports = with inputs.self.modules.nixos; [
      wireguard-minksdHome
    ];
  };
}

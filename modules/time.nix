{
  inputs,
  ...
}: {
  flake.modules.nixos.time = {lib, config, ...}: {
    time.timeZone = lib.mkDefault "America/New_York";
    networking.timeServers = lib.mkDefault [ "time.nist.gov" ];
  };
}

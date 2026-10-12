{
  config,
  lib,
  inputs,
  ...
}:

{
  options.minksd.openvpn = lib.mkEnableOption {};
  config = lib.mkIf (config.minksd.openvpn == true){
    programs.openvpn3.enable = true;
    programs.openvpn3.package = inputs.nixpkgs-master.legacyPackages.x86_64-linux.openvpn3;
  };
}

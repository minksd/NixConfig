{
  pkgs,
  lib,
  stdenv,
  config,
  inputs,
  globals,
  system,
  ...
}:
{

  config = {
    environment.systemPackages = [
      inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
    services.openssh = {
      enable = lib.mkDefault true;
    };

    age = {
      secrets = {
        minksdPass.file = "${globals.secretsDir}/minksdPass.age";
        home_minksd-ddns.file = "${globals.secretsDir}/home_minksd-ddns.age";
        wg-minksdHome.file = "${globals.secretsDir}/wg-minksdHome.age";
        wg-minksdLaptop.file = "${globals.secretsDir}/wg-minksdLaptop.age";
      };
    };
  };

}

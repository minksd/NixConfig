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
      enable = true;
    };

    age = {
      secrets = {
        minksdPass.file = "${globals.secretsDir}/minksdPass.age";
        minksdHome-ddns.file = "${globals.secretsDir}/minksdHome-ddns.age";
        wg-minksdHome.file = "${globals.secretsDir}/wg-minksdHome.age";
        wg-minksdLaptop.file = "${globals.secretsDir}/wg-minksdLaptop.age";
      };
    };
  };

}

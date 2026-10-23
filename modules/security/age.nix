{
  inputs,
  ...
}:{
  flake.modules.nixos.age = {pkgs, lib, config, ...}: {
    imports = [
      inputs.self.modules.generic.secrets
      inputs.agenix.nixosModules.default
    ];

    #Agenix needs openssh (or similar) enabled so that it can guarantee that host/users keys are available.
    services.openssh.enable = true;

    environment.systemPackages = [
      inputs.agenix.packages."${pkgs.hostPlatform.system}".default
    ];

    age = {
      secrets = with config.secrets; {
        minksdPass.file = password.minksd;
        minksdHome-ddns.file = api.cloudflare;
        wg-minksdHome.file = wireguard.minksdHome;
        wg-minksdLaptop.file = wireguard.minksdLaptop;
        wg-spot-color-site-02.file = wireguard.spot-color-site-02;
        vaultwarden-ssl-private-key = {
          name = "vaultwarden.key";
          file = ssl.vaultwarden;
          owner = "nginx";
          group = "nginx";
          mode = "400";
        };
      };
    };
  };
}

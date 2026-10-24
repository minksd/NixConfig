{
  flake.modules.nixos.vaultwarden = {
    services = {
      nginx = {
        enable = true;
      };
      vaultwarden = {
        enable = true;
        configureNginx = true;

        config = {
          SIGNUPS_ALLOWED = false;
        };

      };
    };
    networking.firewall.allowedTCPPorts = [ 443 ];
  };
}

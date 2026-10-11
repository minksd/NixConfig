{
  config,
  ...
}:
{
  config = {
    services = let
      domain = "vaultwarden.minksd.us";
in {
      nginx = {
        virtualHosts.${domain} = {
          sslCertificate = ./vaultwarden.crt;
          sslCertificateKey = config.age.secrets.vaultwarden-ssl-private-key.path;
        };
      };
      vaultwarden = {
        inherit domain;
        enable = true;
        configureNginx = true;

        config = {
          SIGNUPS_ALLOWED = false;
          ADMIN_TOKEN="$argon2id$v=19$m=65540,t=3,p=4$1cqYaVM2XFCdI0OYjsy1UNsTrRXFO6J9g3TwXSO1hFI$zVnRx4NTjpmuewS+XLMGr7Qo3zvmh6Tzu4V8kwfynts";
        };

      };
    };
  };
  
}

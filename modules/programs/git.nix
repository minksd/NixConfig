{
  inputs,
  ...
}: {
  flake.modules.nixos.git = {pkgs, ...}: {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        git
        git-credential-oauth
        gh
        ;
    };
    programs.git = {
      enable = true;
      config = [
        {
          credential = {
            helper = "cache --timeout 21600";
          };
        }
        {
          credential = {
            helper = "oauth";
          };
        }
        {
          push = {
            autoSetupRemote = true;
          };
        }
      ];
    };
  };
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Daniel Minks";
          email = "danielminks1230@gmail.com";
        };

      };
      #Because the default changed from openpgp to null and I don't use this setting.
      signing.format = null;
    };
  };
}

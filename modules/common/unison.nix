{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:{
  config = {
    environment.systemPackages = [ pkgs.unison ];
  };
  
  home-manager.users.${config.minksd} = lib.mkIf( config.networking.hostName == "minksdLaptop") {
    services.unison = {
      enable = true;
      pairs = {
        "documents" = {
          roots = [
            "/home/${config.user}/documents"
            "ssh://192.168.2.1/home/${config.user}/documents"
          ];
        };
        "projects" = {
          roots = [
            "/home/${config.user}/projects"
            "ssh://192.168.2.1/home/${config.user}/projects"
          ];
        };
      };
    };
  };
}

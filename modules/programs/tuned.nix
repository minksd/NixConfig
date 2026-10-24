{
  flake.modules.nixos.tuned = {pkgs, ...}: {
    services.tuned = {
      enable = true;
      settings = {
        dynamic_tuning = true;
      };
      package = pkgs.tuned;
    };
  };
}

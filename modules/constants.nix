{
  inputs,
  ...
}:
{
  flake.modules.generic.constants = 
    {lib, config, ...}:{
      options.constants = lib.mkOption {
        type = lib.types.attrsOf lib.types.any;
        readOnly = true;
        default = rec {
          base-url = "minksd.us";
          wireguard = {
            url = "wireguard.${config.constants.base-url}";
          };
          pkgs = import inputs.nixpkgs {
            config = {
              allowUnfree = true;
            };
          };
          keys = {
          };
        };
      };
    };
}

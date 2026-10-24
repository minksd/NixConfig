{
...
}: {
  flake.modules.nixos.cheapino = {
    services.udev.extraRules = ''
        #For vial to access my cheapino
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';
  };
}

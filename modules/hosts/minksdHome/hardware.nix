{
  ...
}:
{
  flake.modules.nixos.minksdHome = {config, pkgs, ...}: {
    boot = {
      swraid = {
        enable = true;
        mdadmConf = ''
        ARRAY /dev/md/NIXBOOT level=raid1 num-devices=2 metadata=0.90 UUID=955e248a:86cfc610:b859f0f2:1a8f29b7
        ARRAY /dev/md/NIXSWAP level=raid0 num-devices=2 metadata=1.2 UUID=52cfdedf:9349df8b:fc996bba:c4d0783c
        ARRAY /dev/md/NIXROOT level=raid0 num-devices=2 metadata=1.2 UUID=34277524:7d9ceb21:35ec9aec:1791a2
        MAILADDR danielminks1230@gmail.com
      '';
      };
    };

    environment.systemPackages = [ pkgs.btrfs-progs ];
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };
      "/steam" = {
        device = "/dev/disk/by-uuid/256011a9-7c27-4596-b7de-b4c3f6106532";
        fsType = "btrfs";
        options = [
          "compress=zstd:3"
          "noatime"
          "nofail"
        ];
      };
    };
    swapDevices = [ { device = "/dev/md/NIXSWAP"; } ];
    
    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580; # 1050ti out of support :(
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
      };
      graphics.enable = true;
      graphics.enable32Bit = true;

    };
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}

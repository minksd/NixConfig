{
  ...
}:
{
  flake.modules.nixos.minksdHome = {pkgs, ...}: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      tmp = {
        useTmpfs = true;
        tmpfsSize = "10%";
        tmpfsHugeMemoryPages = "within_size";
        cleanOnBoot = true;
      };
      initrd = {
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usbhid"
          "sd_mod"

        ];
        kernelModules = [ ];
      };
      kernelModules = [
        "i915"
      ];
      kernelParams = [
        "nvidia-drm.modeset=1"
        "nvidia-drm.fbdev=1"
        "nvidia.NVreg_EnableGpuFirmware=0"
      ];
      extraModulePackages = [ ];
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 30;
      };
      kernel.sysctl = {
        "vm.swappiness" = 20;
      };
    };
    };
}

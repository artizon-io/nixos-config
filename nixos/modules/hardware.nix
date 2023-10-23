{ config, lib, pkgs, user, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NIXOS-BOOT";
      fsType = "vfat";
    };
    "/boot/efi" = {
      device = "/boot";
      fsType = "none";
      options = [ "bind" ];
    };

    "/mnt/a" = {
      device = "/dev/disk/by-label/A";
      fsType = "ntfs";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-label/swap"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

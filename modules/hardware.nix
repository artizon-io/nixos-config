{ config, lib, pkgs, user, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    initrd.kernelModules = [
# "nvidia"
# "nvidia_modeset"
# "nvidia_uvm"
# "nvidia_drm"
];
    kernelModules = [ "kvm-amd" ];
    # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    extraModulePackages = [];
    # extraModprobeConfig = "options nvidia-drm modeset=1";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };
    # "/" = {
    #   device = "none";
    #   fsType = "tmpfs";
    #   options = [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
    # };

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

    # "/home/${user}" = {
    #   device = "none";
    #   fsType = "tmpfs"; # Can be stored on normal drive or on tmpfs as well
    #   options = [ "size=4G" "mode=777" ];
    # };

    # "/nix" = {
    #   # can be LUKS encrypted
    #   device = "/dev/disk/by-label/NIXOS-NIX";
    #   fsType = "ext4";
    #   neededForBoot = true;
    # };

    # "/persist" = {
    #   device = "/dev/disk/by-label/NIXOS";
    #   fsType = "ext4";
    #   neededForBoot = true;
    # };
  };

  # swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

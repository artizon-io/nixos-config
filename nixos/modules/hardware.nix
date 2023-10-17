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
    # "/" = {
    #   device = "none";
    #   fsType = "tmpfs";
    # };
    # "/home/${user}" = {
    #   device = "none";
    #   fsType = "tmpfs";
    # };
    # "/nix" = {
    #   device = "/dev/disk/by-label/NIXOS";
    #   fsType = "ext4";
    # };
    # "/boot" = {
    #   device = "/dev/disk/by-label/NIXOS-BOOT";
    #   fsType = "vfat";
    # };
    # "/boot/efi" = {
    #   device = "/boot";
    #   fsType = "none";
    #   options = [ "bind" ];
    # };
    "/boot/efi" = {
      device = "/dev/disk/by-label/NIXOS-BOOT";
      fsType = "vfat";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-label/swap"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

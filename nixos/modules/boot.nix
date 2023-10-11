{ config, options, pkgs, inputs, ... }:

{
  # TODO: migrate to GRUB2

  # Bootloader systemd/grub
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = false;
  };

  # Filesystems
  boot.supportedFilesystems = [ "ntfs" ];
}
# systemd-boot modules
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/system/boot/systemd
# https://nixos.wiki/wiki/Bootloader

{ config, options, pkgs, inputs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ]; # Actual fs; Not for initrd
  };
}

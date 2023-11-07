# Bluetooth module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/hardware/bluetooth.nix
# https://nixos.wiki/wiki/Bluetooth

{ config, options, pkgs, inputs, ... }:

{
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
}

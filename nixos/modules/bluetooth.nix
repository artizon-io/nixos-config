# https://nixos.wiki/wiki/Bluetooth
# Command bluetoothctl is available on CLI

{ config, options, pkgs, inputs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
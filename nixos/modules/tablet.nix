# OpenTabletDriver module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/opentabletdriver.nix

{ config, options, pkgs, inputs, ... }:

{
  hardware.opentabletdriver.enable = false;
}

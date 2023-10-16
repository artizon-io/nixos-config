# OpenRGB module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/hardware/openrgb.nix
# https://nixos.wiki/wiki/OpenRGB

{ config, options, pkgs, inputs, ... }:

{
  services.hardware.openrgb = {
    enable = true;
  };
}

# Printing modules
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/printing

{ config, options, pkgs, inputs, ... }:

{
  services.printing.enable = true;
}

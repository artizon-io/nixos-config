# Tailscale module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/tailscale.nix
# https://nixos.wiki/wiki/Tailscale

{ config, options, pkgs, inputs, ... }:

{
  services.tailscale.enable = true;
}

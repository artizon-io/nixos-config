# GNOME Keyring module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/desktops/gnome/gnome-keyring.nix
{ config, options, pkgs, inputs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
}

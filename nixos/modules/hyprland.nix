# Hyprland module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/hyprland.nix
# https://nixos.wiki/wiki/Hyprland

{ config, options, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };
}

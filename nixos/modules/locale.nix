# Locale module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/locale.nix

{ config, options, pkgs, inputs, ... }:

{
  time.timeZone = "Asia/Hong_Kong";
}

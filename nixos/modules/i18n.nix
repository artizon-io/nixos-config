# i18n module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/i18n.nix

{ config, options, pkgs, inputs, ... }:

{
  i18n = {
    defaultLocale = "en_HK.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
        rime
      ];
    };
  };
}

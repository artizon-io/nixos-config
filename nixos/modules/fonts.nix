# Font modules
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/fonts
# https://nixos.wiki/wiki/Fonts

{ config, options, pkgs, inputs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" ];
      })
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "DroidSansMono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}

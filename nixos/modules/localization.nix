{ config, options, pkgs, inputs, ... }:

{
  # Locale
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_HK.UTF-8";

  # Fonts
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

  # Input
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      rime
    ];
  };
}
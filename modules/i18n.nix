# i18n module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/i18n.nix

# Font modules
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/fonts
# https://nixos.wiki/wiki/Fonts

# Locale module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/locale.nix

{ config, options, pkgs, inputs, ... }:

{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # inputMethod = {
    #   enabled = "fcitx5";
    #   fcitx5.addons = with pkgs; [
    #     fcitx5-chinese-addons
    #     fcitx5-gtk  # Support GTK apps
    #   ];
    # };
  };

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

  time.timeZone = "Asia/Hong_Kong";
}

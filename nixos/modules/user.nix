{ config, options, pkgs, home-manager, user, ... }:

{
  imports = [
    # home-manager.nixosModules.home-manager
  ];

  # TODO: migrate to home-manager
  # home-manager = {
  #   users = {
  #     ${user} = {};
  #   };
  # };

  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"  # Enable sudo
      ];
      initialPassword = "password";
      packages = with pkgs; [
        wget
        git
        croc
        zoxide
        curl 
        zsh
        starship
        rustup
        gh
        supabase-cli
        fd
        fzf
        ripgrep
        less
        lf
        tree
        bat
        bottom
        file
        killall
        # toybox  # Lightweight implementation of some Unix command line utils

        # Wayland
        waybar  # Status bar
        dunst  # Notification
        swww  # Wallpaper
        rofi-wayland  # App launcher
        networkmanagerapplet  # Network manager applet
        grim  # Screenshot
        slurp  # Select region (for e.g. screenshot)
        wl-clipboard  # Clipboard

        # Applications
        brave
        vscode
        firefox-devedition  
        kitty
        openrgb
        krita
        imv  # Image viewer
        hyprpicker  # Color picker
      ];
    };
  };
}
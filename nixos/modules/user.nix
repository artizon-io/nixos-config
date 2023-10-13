{ config, options, pkgs, user, system, inputs, ... }:

{
  imports = [
    # TODO: migrate to home-manager
    # inputs.home-manager.nixosModules.home-manager
    # TODO: run xremap as service
    # inputs.xremap-flake.nixosModules.default
  ];

  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"  # Enable sudo
      ];
      initialPassword = "password";
      packages = with pkgs; [
        bottom
        croc
        zoxide
        zsh
        starship
        rustup
        gh
        supabase-cli
        inputs.xremap-flake.packages.${system}.default

        # Wayland
        waybar  # Status bar
        dunst  # Notification
        swww  # Wallpaper
        rofi-wayland  # App launcher
        networkmanagerapplet  # Network manager applet
        grim  # Screenshot
        slurp  # Select region (for e.g. screenshot)
        wl-clipboard  # Clipboard CLI
        cliphist # Clipboard manager
        wlsunset # Day/night gamma adjustment

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
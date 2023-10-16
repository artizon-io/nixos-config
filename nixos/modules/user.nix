# Users groups module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/users-groups.nix

{ config, options, pkgs, user, system, inputs, ... }:

{
  imports = [
    # inputs.home-manager.nixosModules.home-manager
    # inputs.xremap-flake.nixosModules.default
  ];

  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel" # Enable sudo
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
        waybar # Status bar
        dunst # Notification
        swww # Wallpaper
        rofi-wayland # App launcher
        networkmanagerapplet # Network manager applet
        grim # Screenshot
        slurp # Select region (for e.g. screenshot)
        wl-clipboard # Clipboard CLI
        swappy # Screenshot editing tool
        cliphist # Clipboard manager
        wlsunset # Day/night gamma adjustment

        # Applications
        brave
        vscode
        firefox-devedition
        kitty
        krita
        imv # Image viewer
        hyprpicker # Color picker
        clapper # Media/video player
        celluloid # Media/video player
        gnome.seahorse # GNOME keyring GUI
        helvum # Pipewire GUI
      ];
    };
  };
}

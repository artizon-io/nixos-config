# Users groups module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/users-groups.nix

{ config, options, pkgs, pkgs_unstable, user, system, inputs, ... }:

{
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel" # Enable sudo
        "docker"
      ];
      initialPassword = "password";
      packages = (with pkgs; [
        # Others
        bottom
        croc
        zoxide
        zsh
        starship
        rustup
        docker-client # Docker CLI

        # Wayland
        # (waybar.overrideAttrs (oldAttrs: {
        #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        # })) # Status bar
        # dunst # Notification
        # swww # Wallpaper
        # rofi-wayland # App launcher
        # networkmanagerapplet # Network manager applet
        # grim # Screenshot
        # slurp # Select region (for e.g. screenshot)
        # wl-clipboard # Clipboard CLI
        # swappy # Screenshot editing tool
        # cliphist # Clipboard manager
        # wlsunset # Day/night gamma adjustment

        # Applications
        imv # Image viewer
        hyprpicker # Color picker
        clapper # Media/video player
        celluloid # Media/video player
        gnome.seahorse # GNOME keyring GUI
        helvum # Pipewire GUI

      ]) ++ (with pkgs_unstable; [
        # Others (unstable)
        supabase-cli
        gh

        # Applications (unstable)
        brave
        vscode
        firefox-devedition
        kitty
        krita
        spotify
      ] ++ [
        # Using vscode-1.81 for now
        # https://github.com/microsoft/vscode/issues/184124
        # (import
        #   (builtins.fetchGit {
        #     name = "vscode-1.81";
        #     url = "https://github.com/NixOS/nixpkgs/";
        #     ref = "refs/heads/nixpkgs-unstable";
        #     rev = "976fa3369d722e76f37c77493d99829540d43845";
        #   })
        #   {
        #     inherit system;

        #     config = {
        #       allowUnfree = true;
        #     };
        #   }).vscode
      ]);
    };
  };
}

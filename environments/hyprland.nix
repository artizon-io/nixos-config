{ config, lib, pkgs, modulesPath, user, ... }:

{
  services.xserver = {
    displayManager = {
      lightdm.enable = false;
    };
  };

  # A framework for allowing desktop applications to use resources outside of their sandbox e.g. file picker
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # Prevent cursor from going invisible
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };

  services.gnome.gnome-keyring.enable = true;

  users.users.${user}.packages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })) # Status bar
    dunst # Notification
    swww # Wallpaper
    rofi-wayland # App launcher
    networkmanagerapplet # Network manager applet
    grim # Screenshot
    slurp # Region selector
    wl-clipboard # Clipboard CLI
    swappy # Screenshot editing tool
    cliphist # Clipboard manager
    wlsunset # Day/night gamma adjustment
    hyprpicker # Color picker

    gnome.seahorse # GNOME keyring GUI
    # blueman # Bluetooth manager GUI
  ];

  services.xremap = {
    # withHypr = true;
    # https://github.com/xremap/nix-flake/issues/40
    withWlroots = true;
    config = {
      modmap = [];
      keymap = [];
    };
  };
}

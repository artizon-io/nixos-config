{ config, lib, pkgs, pkgs_unstable, user, modulesPath, ... }:

{
  services.xserver = {
    displayManager = {
      gdm.enable = true;
      startx.enable = true;
    };

    desktopManager = {
      gnome.enable = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user}.packages = with pkgs; [
    gnomeExtensions.xremap # Allow xremap to fetch the focused app name using D-Bus

    xclip # X11 clipboard CLI
    xorg.xev # X11 event viewer
  ];

  services.xremap = {
    withGnome = true;
    serviceMode = "user";  # By default service is runs as root
    config = {
      modmap = [
        {
          name = "Gnome";
          remap = {
            "KEY_LEFTMETA" = {
              alone = [ ];
              held = "KEY_LEFTMETA";
              alone_timeout_millis = 100000;
            };
          };
        }
      ];
      keymap = [
        {
          name = "Gnome";
          exact_match = true;
          remap = {
            "super-space" = "KEY_LEFTMETA";
            "super-5" = "super-shift-5";
            "super-6" = "super-shift-6";
            "super-7" = "super-shift-7";
            "super-8" = "super-shift-8";
            "super-9" = "super-shift-9";
          };
        }
      ];
    };
  };
}

# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

# nixpkgs 23.05 nix modules options
# https://search.nixos.org/options?channel=23.05

{ config, options, pkgs, pkgs_unstable, inputs, user, ... }:

{
  imports = [
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/graphics.nix
    ./modules/hardware.nix
    ./modules/i18n.nix
    ./modules/keyring.nix
    ./modules/network.nix
    ./modules/openrgb.nix
    ./modules/printing.nix
    ./modules/sound.nix
    ./modules/tablet.nix
    ./modules/docker.nix
    # ./modules/keyremap.nix

    "${inputs.impermanence}/nixos.nix"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "23.05";

  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # System nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    nil # Nix LSP
    nixpkgs-fmt # Nix formatter
    wget
    git
    curl
    fd
    ripgrep
    less
    tree
    bat
    lf
    file
    fzf
    unzip
    delta # Code diff
    exa # ls replacement
    killall
    toybox # Lightweight implementation of some Unix command line utils

    xorg.xinit
  ] ++ (with pkgs.gnome; [
    adwaita-icon-theme
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator # System tray
  ]);

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];

  # dconf is a low-level configuration system.
  # Its main purpose is to provide a backend to GSettings on platforms that don't already have configuration storage systems.
  programs.dconf.enable = true;

  # environment.gnome.excludePackages = (with pkgs; [
  #   gnome-photos
  #   gnome-tour
  # ]) ++ (with pkgs.gnome; [
  #   cheese # webcam tool
  #   gnome-music
  #   gnome-terminal
  #   gedit # text editor
  #   epiphany # web browser
  #   geary # email reader
  #   evince # document viewer
  #   gnome-characters
  #   totem # video player
  #   tali # poker game
  #   iagno # go game
  #   hitori # sudoku game
  #   atomix # puzzle game
  # ]);

  # Environment variables
  environment.variables = {
    # For Wayland
    # WLR_NO_HARDWARE_CURSORS = "1"; # Prevent cursor from going invisible
    # NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland

    # Others
    SHELL = "zsh";
  };

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

  environment.persistence."/persist" = {
    # bind mounted from e.g. /persist/etc/nixos to /etc/nixos
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/lib/bluetooth"
      "/var/log"
      "/var/lib"
    ];
    files = [
      #  NOTE: if you persist /var/log directory,  you should persist /etc/machine-id as well
      #  otherwise it will affect disk usage of log service
      "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = { mode = "u=rwx,g=,o="; };
      }
    ];
    hideMounts = false;
    users.${user} = {
      directories = [
        "Downloads"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local"
        ".warp"
        ".git"
        ".config"
        ".gitmodules"
        ".vscode"
      ];
      files = [
        "README.md"
        ".gitignore"
        ".gitconfig"
        ".zshrc"
        ".zprofile"
        "INSTRUCTIONS.md"
      ];
    };
  };
}

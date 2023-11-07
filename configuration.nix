# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

{ config, options, pkgs, pkgs_unstable, inputs, user, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = (with pkgs; [
      vim
      git
      lf
      bottom
      croc
      zoxide
      zsh
      starship
      rustup
      docker-client # Docker CLI

      imv # Image viewer
      hyprpicker # Color picker
      clapper # Media/video player
      celluloid # Media/video player
      gnome.seahorse # GNOME keyring GUI
      helvum # Pipewire GUI
      supabase-cli
      gh
      nil # Nix LSP
      nixpkgs-fmt # Nix formatter
      wget
      curl
      fd
      ripgrep
      less
      tree
      bat
      file
      fzf
      unzip
      delta # Code diff
      exa # ls replacement
      killall
      toybox # Lightweight implementation of some Unix command line utils

      gnomeExtensions.xremap # Allow xremap to fetch the focused app name using D-Bus
      xorg.xev # X11 event viewer
    ]) ++ (with pkgs_unstable; [
      brave
      vscode
      firefox-devedition
      kitty
      krita
      spotify
    ]);
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

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

  environment.variables = {
    # SHELL = "zsh"; # Cause xserver to crash (startx/xinit)
    PAGER = "bat";
    EDITOR = "vim";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

  services.hardware.openrgb.enable = true;

  hardware.opentabletdriver.enable = false;

  hardware.bluetooth.enable = false;
}

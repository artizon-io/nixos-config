# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

# nixpkgs 23.05 nix modules options
# https://search.nixos.org/options?channel=23.05

{ config, options, pkgs, inputs, ... }:

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
    ./modules/user.nix
    ./modules/docker.nix
    ./modules/keyremap.nix
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
  ];

  # Environment variables
  environment.variables = {
    # For Wayland
    WLR_NO_HARDWARE_CURSORS = "1"; # Prevent cursor from going invisible
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland

    # Others
    SHELL = "zsh";
  };
}

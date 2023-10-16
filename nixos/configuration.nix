# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

# nixpkgs 23.05 nix modules options
# https://search.nixos.org/options?channel=23.05

{ config, options, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/fonts.nix
    ./modules/graphics.nix
    ./modules/hyprland.nix
    ./modules/i18n.nix
    # ./modules/impermanence.nix
    ./modules/keyring.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/nginx.nix
    ./modules/openrgb.nix
    ./modules/openssh.nix
    ./modules/printing.nix
    ./modules/sound.nix
    ./modules/tablet.nix
    ./modules/tailscale.nix
    ./modules/user.nix
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
    neovim
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
    killall
    toybox # Lightweight implementation of some Unix command line utils
  ];

  # Environment variables
  environment.sessionVariables = {
    # For Wayland
    WLR_NO_HARDWARE_CURSORS = "1"; # Prevent cursor from going invisible
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };
}

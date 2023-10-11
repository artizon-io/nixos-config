# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

# nixpkgs 23.05 nix modules options
# https://search.nixos.org/options?channel=23.05

{ config, options, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/graphics.nix
    ./modules/localization.nix
    ./modules/network.nix
    ./modules/printing.nix
    ./modules/sound.nix
    ./modules/tablet.nix
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
  ];

  # Environment variables
  environment.sessionVariables = {
    # For Wayland
    WLR_NO_HARDWARE_CURSORS = "1";  # Prevent cursor from going invisible
    NIXOS_OZONE_WL = "1";  # Hint electron apps to use wayland
  };
}

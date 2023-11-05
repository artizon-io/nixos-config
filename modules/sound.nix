# Pipewire module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/desktops/pipewire/pipewire.nix
# https://nixos.wiki/wiki/PipeWire

{ config, options, pkgs, inputs, ... }:

{
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
}

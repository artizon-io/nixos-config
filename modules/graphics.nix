# NVidia module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/video/nvidia.nix
# https://nixos.wiki/wiki/Nvidia

# XServer module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/xserver.nix

# OpenGL module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/opengl.nix

# XDG modules
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/xdg

# Hyprland module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/hyprland.nix
# https://nixos.wiki/wiki/Hyprland

{ config, options, pkgs, inputs, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # Use propritary version of the kernel module
    nvidiaSettings = true; # Enable NVidia settings menu
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
    layout = "us";
    xkbVariant = "";
    autoRepeatDelay = 180;
    autoRepeatInterval = 30;

    displayManager = {
      lightdm.enable = false;
    };
  };

  xdg = {
    # Portal (a framework for allowing desktop applications to use resources outside of their sandbox e.g. file picker)
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };
}

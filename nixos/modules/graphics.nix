{ config, options, pkgs, inputs, ... }:

{
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVidia
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;  # Use propritary version of the kernel module
    nvidiaSettings = true;  # Enable NVidia settings menu
    package = config.boot.kernelPackages.nvidiaPackages.stable;  
  };
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # X
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    libinput.enable = true;
    layout = "us";
    xkbVariant = "";
    autoRepeatDelay = 120;
    autoRepeatInterval = 30;
  };

  # Wayland
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;  # Required for running X applications on wayland
  };

  # XDG
  xdg = {
    # Portal (a framework for allowing desktop applications to use resources outside of their sandbox e.g. file picker)
    portal.enable = true;
    portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
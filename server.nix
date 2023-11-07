{ config, options, pkgs, inputs, ... }:

{
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
    hostName = "nixos";
    firewall = {
      enable = false;
    };
  };

  # https://man.archlinux.org/man/NetworkManager-wait-online.service.8.en
  systemd.services.NetworkManager-wait-online.enable = false;

  services.nginx = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    banner = "NixOS"; # Message to display to the remote user before authentication is allowed
  };

  services.tailscale.enable = true;
}

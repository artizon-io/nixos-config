{ config, options, pkgs, inputs, ... }:

{
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
    hostName = "nixos";
    firewall = {
      enable = false;
      # allowedTCPPorts = [ 80 443 ];
      # allowedUDPPorts = [ ];
    };
  };

  # OpenSSH server
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    banner = "Artizon Lab";  # Message to display to the remote user before authentication is allowed
  };

  # Web server
  services.nginx = {
    enable = true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # Disable NetworkManager-wait-online.service
  # https://man.archlinux.org/man/NetworkManager-wait-online.service.8.en
  systemd.services.NetworkManager-wait-online.enable = false;
}
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

  # https://man.archlinux.org/man/NetworkManager-wait-online.service.8.en
  systemd.services.NetworkManager-wait-online.enable = false;
}

# Nginx modules
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/http/nginx
# https://nixos.wiki/wiki/Nginx

# OpenSSH server (sshd) module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/ssh/sshd.nix

# Tailscale module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/tailscale.nix
# https://nixos.wiki/wiki/Tailscale

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
    banner = "Artizon Lab"; # Message to display to the remote user before authentication is allowed
  };

  services.tailscale.enable = true;
}

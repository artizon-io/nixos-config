# OpenSSH server (sshd) module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/ssh/sshd.nix

{ config, options, pkgs, inputs, ... }:

{
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    banner = "Artizon Lab"; # Message to display to the remote user before authentication is allowed
  };
}

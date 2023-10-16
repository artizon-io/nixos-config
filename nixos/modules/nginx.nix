# Nginx modules
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/http/nginx
# https://nixos.wiki/wiki/Nginx

{ config, options, pkgs, inputs, ... }:

{
  services.nginx = {
    enable = true;
  };
}

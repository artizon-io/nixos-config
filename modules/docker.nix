# https://nixos.wiki/wiki/Docker

{ config, options, pkgs, inputs, ... }:

{
  virtualisation.docker.enable = true;
}
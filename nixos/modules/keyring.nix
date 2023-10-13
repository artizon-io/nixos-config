# GNOME Keyring
# https://wiki.gnome.org/Projects/GnomeKeyring/Pam
{ config, options, pkgs, inputs, ... }:

{
  security.pam.services.sddm.enableGnomeKeyring = true;
}
{ config, lib, pkgs, user, modulesPath, ... }:

{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
    };

    "/home/${user}" = {
      device = "none";
      fsType = "tmpfs"; # Can be stored on normal drive or on tmpfs as well
      options = [ "size=4G" "mode=777" ];
    };

    "/nix" = {
      # can be LUKS encrypted
      device = "/dev/disk/by-label/NIXOS-NIX";
      fsType = "ext4";
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
      neededForBoot = true;
    };
  };

  environment.persistence."/persist" = {
    # bind mounted from e.g. /persist/etc/nixos to /etc/nixos
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/lib/bluetooth"
      "/var/log"
      "/var/lib"
    ];
    files = [
      #  NOTE: if you persist /var/log directory,  you should persist /etc/machine-id as well
      #  otherwise it will affect disk usage of log service
      "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = { mode = "u=rwx,g=,o="; };
      }
    ];
    hideMounts = false;
    users.${user} = {
      directories = [
        "Downloads"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local"
        ".warp"
        ".git"
        ".config"
        ".gitmodules"
        ".vscode"
      ];
      files = [
        "README.md"
        ".gitignore"
        ".gitconfig"
        ".zshrc"
        ".zprofile"
        "INSTRUCTIONS.md"
      ];
    };
  };
}

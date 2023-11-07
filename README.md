# NixOS Configuration

Label boot partition as `NIXOS-BOOT`
Label main partition as `NIXOS`

Enable `xremap` and other ext. in `gnome-extensions-app` (to enable app specific keymaps)

```bash
sudo nixos-rebuild switch --flake <repo-url or path> [--install-bootloader]
```

**Useful commands**

- `bootctl list` to check if initrd is configured propertly
- `systemctl restart` to restart running services
- `journalctl` to check logs. `-n` for last `x` entries; `--user` for user space programs; `-p` for log level; `-u` for service name
- `lsblk -o LABEL,MOUNTPOINTS,NAME,...` to gather disks/partitions info
- `e2label` or `fatlabel` or ... for partition renaming
- `df -h` to check disk usage
- `lsmod` to list kernel modules
- `man configuration.nix` or `nixos-help` for offline help
- Live usb NixOS's disk manager GUI for partition management
- `nix-collect-garbage` if boot partition is full
- vim's `:tabe` and `:tabp` `:tabn` for preserving paste-bin/register when stuck with CLI
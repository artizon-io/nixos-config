# NixOS Configuration

Label boot partition as `NIXOS-BOOT`
Label main partition as `NIXOS`

Enable `xremap` and other ext. in `gnome-extensions-app` (to enable app specific keymaps)

```bash
sudo nixos-rebuild switch --flake <repo-url or path> [--install-bootloader]
```

**Useful commands**

- `bootctl list` to check if initrd is configured propertly
- `systemctl restart` to restart running services; `--user` for user programs; by default user programs are not included
- `journalctl` to check logs. `-n` for last `x` entries; `--user` for user programs; `-p` for log level; `-u` for service name
- `hyprctl` for hyprland management
- `lsblk -o LABEL,MOUNTPOINTS,NAME,...` to gather disks/partitions info
- `e2label` or `fatlabel` or ... for partition renaming
- `df -h` to check disk usage
- `lsmod` to list kernel modules
- `man configuration.nix` or `nixos-help` for offline help
- Live usb NixOS's disk manager GUI for partition management
- `nix-collect-garbage` if boot partition is full
- vim's `:tabe` and `:tabp` `:tabn` for preserving paste-bin/register when stuck with CLI

## Issues

**Common**

- Tablet can crash krita and opentablet causes `"initrd not found"`

**Gnome**

- `ctrl+alt` key chord somehow got interpreted as `ctrl`
- (In X) vscode spawns with a blank window unless the `--disable-gpu` flag is supplied, but the cursor flickers very badly if gpu is disabled and can disrupt normal text editing
- Wake up from hibernate/sleep causes the gnome UI to break (go black)

**Hyprland**

- Spawning multiple windows of vscode can crash the whole vscode process. Forcing vscode to open under Xwayland suffers same problem as in gnome. Workaround is to spawn new window from within existing window
- Limited display manager options (only lighthdm available)
- Rofi in a broken state if workspace is switched while rofi is opened
- ibus not working; only fcitx5 works
- xremap cannot gather the focused application's info (for app-specific keymaps) for hypr. With the `wlroot` feature it works for now

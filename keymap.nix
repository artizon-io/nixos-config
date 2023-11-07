{ config, options, pkgs, inputs, user, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  hardware.uinput.enable = true;

  # https://github.com/xremap/nix-flake/#Configuration
  services.xremap = {
    userName = user;
    # withHypr = true;
    withGnome = true;
    serviceMode = "user";  # By default service is runs as root
    config = {
      # https://github.com/k0kubun/xremap#configuration
      modmap = [
        {
          name = "Gnome";
          remap = {
            "KEY_LEFTMETA" = {
              alone = [ ];
              held = "KEY_LEFTMETA";
              alone_timeout_millis = 100000;
            };
          };
        }
      ];
      keymap = [
        {
          name = "Gnome";
          exact_match = true;
          remap = {
            "super-space" = "KEY_LEFTMETA";
            "super-5" = "super-shift-5";
            "super-6" = "super-shift-6";
            "super-7" = "super-shift-7";
            "super-8" = "super-shift-8";
            "super-9" = "super-shift-9";
          };
        }
        {
          name = "Firefox";
          application = {
            only = [
              "firefox"
            ];
          };
          remap = {
            "ctrl-l" = "ctrl-pagedown";
            "ctrl-j" = "ctrl-pageup";
          };
        }
      ];
    };
  };

  users.groups.uinput.members = [ user ];
  users.groups.input.members = [ user ];
}

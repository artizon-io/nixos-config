{ config, options, pkgs, inputs, user, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  hardware.uinput.enable = true;

  users.groups.uinput.members = [ user ];
  users.groups.input.members = [ user ];

  # https://github.com/xremap/nix-flake/#Configuration
  services.xremap = {
    userName = user;
    serviceMode = "user";  # By default service is runs as root
    config = {
      # https://github.com/k0kubun/xremap#configuration
      modmap = [];
      keymap = [
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
}

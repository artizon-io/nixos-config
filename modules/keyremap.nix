{ config, options, pkgs, inputs, user, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  hardware.uinput.enable = true;

  # https://github.com/xremap/nix-flake/#Configuration
  services.xremap = {
    userName = user;
    withHypr = true;
    config = {
      # https://github.com/k0kubun/xremap#configuration
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

  users.groups.uinput.members = [ user ];
  users.groups.input.members = [ user ];
}
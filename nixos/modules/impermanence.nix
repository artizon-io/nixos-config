# Impermanence flake
# https://github.com/nix-community/impermanence
# https://nixos.wiki/wiki/Impermanence

{ config, options, pkgs, inputs, user, ... }:

{
  imports = [
    "${inputs.impermanence}/nixos.nix"
  ];

  environment.persistence."/persist" = {
    # Bind mount "/persist/*" to  "*"
    directories = [

    ];
    files = [

    ];
    users.${user} = {
      directories = [
        "dev"
        "persist"
        "nixos-config"
        "invokeai"
        ".warp"
        ".git"
      ];
      files = [
        ".gitignore"
        ".zprofile"
        ".zshrc"
        "README.md"
        "INSTRUCTIONS.md"
      ];
    };
  };
}

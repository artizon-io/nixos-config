{
  # Run ‘nixos-help’ to get help.

  # Flake format reference
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake#flake-format
  # Nix "derivation" function reference
  # https://nixos.org/manual/nix/stable/language/derivations.html

  # nixos-rebuild CLI
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nixos-rebuild/nixos-rebuild.sh

  # nix build CLI
  # https://github.com/NixOS/nix/blob/master/src/nix/build.cc

  description = "NixOS Config";

  # Flake input reference
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake#flake-inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake.url = "github:xremap/nix-flake";
  };

  # Parameters: set of the input flakes' outputs
  outputs = { self, nixpkgs, ... } @ inputs:
    let
      user = "sam";
      system = "x86_64-linux";

      # Writing NixOS modules
      # https://nixos.org/manual/nixos/unstable/#sec-writing-modules

      # "import" function in Nix
      # https://nixos.org/guides/nix-pills/functions-and-imports#id1376
      # "import" will load default.nix because path is directory
      # https://stackoverflow.com/questions/74464687/whats-the-mechanism-behind-import-nixpkgs-in-nix-flakes
      # Nixpkgs default.nix
      # https://github.com/NixOS/nixpkgs/blob/master/default.nix
      # Nixpkgs flake.nix
      # https://github.com/NixOS/nixpkgs/blob/master/flake.nix
      pkgs = import nixpkgs {
        inherit system;

        # Config options reference
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/config.nix
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = { 
        default = nixpkgs.lib.nixosSystem {
          # nixpkgs/nixos/lib/default.nix
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/default.nix
          # nixpkgs/nixos/lib/eval-config.nix
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix
          # Parameters reference
          # https://nixos.org/manual/nixpkgs/stable/#module-system-lib-evalModules-parameters

          # An attribute set of module arguments that can be used in imports.
          specialArgs = { inherit user system pkgs inputs; };

          # A list of modules. These are merged together to form the final configuration.
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };
    };
}

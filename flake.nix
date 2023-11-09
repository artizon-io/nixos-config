{
  # Run ‘nixos-help’ to get help.
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    xremap-flake.url = "github:xremap/nix-flake";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # impermanence.url = "github:nix-community/impermanence";
  };

  # Parameters: set of the input flakes' outputs
  outputs = { self, nixpkgs, nixpkgs_unstable, ... } @ inputs:
    let
      user = "sam";
      system = "x86_64-linux";

      # Writing NixOS modules
      # https://nixos.org/manual/nixos/unstable/#sec-writing-modules

      # "import" function in Nix
      # https://nixos.org/guides/nix-pills/functions-and-imports#id1376
      # "import" will load default.nix because path is directory
      # https://stackoverflow.com/questions/74464687/whats-the-mechanism-behind-import-nixpkgs-in-nix-flakes
      pkgs = import nixpkgs {
        inherit system;

        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/config.nix
        config = {
          allowUnfree = true;
        };
      };

      pkgs_unstable = import nixpkgs_unstable {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          # nixpkgs/nixos/lib/default.nix
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/default.nix
          # nixpkgs/nixos/lib/eval-config.nix
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix

          # An attribute set of module arguments that can be used in imports.
          specialArgs = { inherit user system pkgs pkgs_unstable inputs; };

          # A list of modules. These are merged together to form the final configuration.
          modules = [
            ./hardware.nix
            ./configuration.nix
            ./locale.nix
            ./server.nix
            ./keymap.nix
            ./environments/gnome.nix
          ];
       };
     };
   };
}

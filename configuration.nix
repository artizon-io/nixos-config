# NixOS module reference
# https://nixos.wiki/wiki/NixOS_modules

{ config, options, pkgs, pkgs_unstable, inputs, user, ... }:

{
  nix = {
    package = pkgs_unstable.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/Apropos
  documentation.man.generateCaches = true; # Automatically build man page index cache when systemPackages change

  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = (with pkgs_unstable; [
      vim
      neovim
      git
      pandoc # Universal markup converter e.g. latex <-> markdown <-> html ...
      # texlive.combined.scheme-full # https://nixos.wiki/wiki/TexLive  Caution: download size ~= 3GB & install size ~= 6GB
      ghostscript # PDF and PostScript interpreter (used by imagemagick for PDF manipulation)
      gojq # Go implementation of jq, a JSON preprocessor
      shellcheck # Shell scripts static analyzer
      lf
      bottom # Top
      nvitop # Performance monitor for nvidia
      duf # Better df
      tldr # Community man entries
      croc
      zoxide
      zsh
      starship
      docker-client # Docker CLI
      tmux
      ncdu # Better du with ncurses
      dogdns # DNS client like dig
      xh # Better curl
      supabase-cli
      gh
      wget
      curl
      fd
      ffmpeg_6-headless # Video/audio manipulation
      imagemagick # Image manipulation
      ripgrep
      less
      tree
      bat
      file
      fzf
      unzip
      delta # Code diff
      eza # ls replacement (maintain fork of exa)
      killall
      toybox # Lightweight implementation of some Unix command line utils
      cargo-tauri

      brave
      vscode
      firefox-devedition
      kitty
      krita
      spotify
      discord
      blender
      imv # Image viewer
      hyprpicker # Color picker
      clapper # Media/video player
      celluloid # Media/video player
      gnome.seahorse # GNOME keyring GUI
      helvum # Pipewire GUI
    ]) ++ (with pkgs_unstable; [
      # Python
      python311 # Required for kitty-save script
      nodePackages.pyright
      ruff # Linter + formatter
      ruff-lsp # Unofficial LSP implementation for ruff

      # Rust
      rust-analyzer
      rustup

      # C/C++
      # https://discourse.nixos.org/u/jonringer
      # https://discourse.nixos.org/t/get-clangd-to-find-standard-headers-in-nix-shell/11268/4
      # gcc13 # Apparently clangd is not well supported
      # llvmPackages_16.clang-unwrapped # Includes clang tools e.g. clangd
      # ccls # C++ language server clang/gcc
      clang
      pkg-config
      gnumake
      clang-tools_16
      bear # Generate compilation database for clang
      clangStdenv # Default build environment for Unix packages
      cmake
      neocmakelsp # Growing CMake LSP
 
      # Configuration (toml, json, yaml)
      taplo # Unofficial TOML language server, from tamasfe

      # Web
      nodejs_20 # Required for copilot.nvim
      nodePackages.typescript-language-server
      vscode-langservers-extracted # JSON, HTML, CSS, ESLint
      nodePackages.tailwindcss
      nodePackages.prettier
      # TODO: https://github.com/tailwindlabs/tailwindcss-intellisense
      # TODO: https://github.com/mdx-js/mdx-analyzer

      # Zig
      zig
      zls # Zig LSP + language server

      # Bash
      nodePackages.bash-language-server # Requires shellcheck (or explainshell)

      # Dotnet / C#
      dotnet-sdk_8
      dotnet-runtime_8
      dotnet-aspnetcore_8
      omnisharp-roslyn # Unofficial

      # Docker
      docker-compose-language-service # By Microsoft

      # Lua
      lua-language-server # By sumneko

      # Terraform
      terraform
      terraform-ls # Official (still infant)
      tflint

      # Go
      go
      gopls # Go official language server

      # Nix
      nil # Unofficial Nix LSP
      nixpkgs-fmt # Unofficial Nix formatter

      # Swift
      swift
      sourcekit-lsp # Apple's LSP implementation for Swift and Objective-C
    ]);
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs_unstable; [
  ];

  # Can interfere with the system. E.g. startx/xinit relies on SHELL
  environment.variables = {};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

  services.hardware.openrgb.enable = true;

  hardware.opentabletdriver.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

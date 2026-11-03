{
  inputs,
  pkgs,
  username,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}";

  home.stateVersion = "26.05";
  home.backupFileExtension = "backup";

  gtk = {
    enable = true;
    colorScheme = "light";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-light";
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  services.playerctld.enable = true;

  home.packages = with pkgs; [
    # ── Core CLI ──────────────────────────────
    git
    vim
    nano
    wget
    curl
    openssl
    tree
    lsof
    killall
    man-pages
    tealdeer
    unzip
    nftables
    netcat

    # ── Search & text processing ──────────────
    jq
    yq-go
    procs
    httpie

    # ── Filesystem ────────────────────────────
    dust
    fd
    bat
    ripgrep

    # ── System monitoring ─────────────────────
    htop
    btop
    bottom
    gtop
    nvitop
    lm_sensors
    powertop
    powerstat

    # ── Dev workflow ──────────────────────────
    just
    gnumake
    direnv
    nix-direnv
    watchexec
    entr
    hyperfine
    tokei
    lima
    ethtool
    opentofu
    appimage-run
    ast-grep
    repomix
    awscli2

    # ── Nix tooling ───────────────────────────
    comma
    nix-output-monitor
    nix-tree
    nix-diff

    # ── Containers ────────────────────────────
    podman
    podman-compose
    podman-desktop

    # ── Database clients ──────────────────────
    rainfrog
    harlequin
    dblab

    # ── Wayland desktop ───────────────────────
    waybar
    hyprlauncher
    hyprpicker
    wl-clipboard
    wl-gammarelay-rs
    libnotify
    grim
    slurp

    # ── Hardware controls ─────────────────────
    brightnessctl
    ddcutil
    pamixer
    pavucontrol
    blueman
    bluetui

    # ── Browsers ──────────────────────────────
    firefox
    google-chrome
    chromium

    # ── GUI apps ──────────────────────────────
    vscode
    slack
    libreoffice
    kdePackages.dolphin

    # ── Lang: Nix ─────────────────────────────
    nixd
    nixfmt

    # ── Lang: Rust ────────────────────────────
    rustc
    cargo
    rust-analyzer

    # ── Lang: Go ──────────────────────────────
    go
    gopls
    gotools
    templ

    # ── Lang: Python ──────────────────────────
    python3
    uv
    python313Packages.python-lsp-server
    ruff
    mypy

    # ── Lang: JS / Web ────────────────────────
    nodejs
    vtsls
    vue-language-server
    tailwindcss-language-server
    emmet-language-server
    vscode-langservers-extracted
    graphql-language-service-cli

    # ── Lang: Lua ─────────────────────────────
    lua
    lua-language-server
    stylua

    # ── Lang: PHP ─────────────────────────────
    php
    phpactor

    # ── Lang: C / Perl ────────────────────────
    gcc
    perl

    # ── Infra & config languages ──────────────
    terraform-ls
    tofu-ls
    tflint
    dockerfile-language-server
    docker-compose-language-service
    bash-language-server
    yaml-language-server
    sqls
  ];

  home.sessionVariables = {
    # Combine Nix profile (icons), system/user Flatpak paths (fuzzel)
    XDG_DATA_DIRS = ''
      $HOME/.nix-profile/share:\
      $XDG_DATA_DIRS:\
      /var/lib/flatpak/exports/share:\
      $HOME/.local/share/flatpak/exports/share:\
    '';
  };
}

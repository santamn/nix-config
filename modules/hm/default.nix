{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./example.nix - add your modules here
  ];

  # ===========================
  # Packages
  # ===========================
  home.packages = with pkgs; [
    # --- Terminal / Shell ---
    ghostty

    # --- Development Tools ---
    lazygit

    # --- LSP & Language Tools ---
    # Go
    go
    gopls
    # Rust
    rustup
    # Haskell
    ghc
    haskell-language-server
    # Clojure
    clojure
    clojure-lsp
    leiningen
    # Python
    python3
    python3Packages.python-lsp-server
    # Lua
    lua
    lua-language-server
    # TypeScript / JavaScript
    nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    # HTML / CSS / JSON
    nodePackages.vscode-langservers-extracted
    # YAML
    yaml-language-server
    # Markdown
    marksman
    # Dockerfile
    dockerfile-language-server-nodejs

    # --- Alternative Commands ---
    eza # ls alternative
    fd # find alternative
    ripgrep # grep alternative
    bat # cat alternative
    fzf # interactive file search
    bottom # top alternative

    # --- Daily Software ---
    slack
    zoom-us
    thunderbird
    wine64
    signal-desktop

    # --- Japanese Input ---
    # fcitx5 is configured at system level (modules/system/default.nix)
    # Config tool can be launched via fcitx5-configtool
    fcitx5-configtool
  ];

  # ===========================
  # HyDenix Module Options
  # ===========================
  hydenix.hm = {
    enable = true;

    # --- Editors ---
    editors = {
      enable = true;
      neovim = true;
      vscode.enable = false; # Not in design policy
      vim.enable = false; # Not in design policy
      default = "nvim";
    };

    # --- Firefox (disabled, using Zen Browser instead) ---
    firefox.enable = false;

    # --- Git ---
    git = {
      enable = true;
      name = "santamn";
      email = "cle.neige@gmail.com";
    };

    # --- Shell ---
    shell = {
      enable = true;
      zsh = {
        enable = true;
        plugins = ["sudo"];
      };
      starship.enable = true;
    };

    # --- Social ---
    social = {
      enable = true;
      discord.enable = true;
      vesktop.enable = false; # Not needed alongside Discord
    };

    # --- Spotify ---
    spotify.enable = true;

    # --- Terminals ---
    terminals = {
      enable = true;
      kitty.enable = false; # Using Ghostty instead
    };
  };

  # ===========================
  # Program-specific configuration
  # ===========================

  # Ghostty terminal configuration
  # Note: Ghostty config is managed via ~/.config/ghostty/config

  # Git extras (delta integration)
  programs.git = {
    delta = {
      enable = true;
    };
  };

  # ===========================
  # Zen Browser Configuration
  # ===========================
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages."${pkgs.system}".default;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # Search engine
      search = {
        default = "DuckDuckGo";
        force = true;
      };

      # Extensions (Firefox Add-ons)
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin # Ad blocker
        darkreader # Dark mode for websites
        # Note: Some extensions may need to be installed manually:
        # - Hide Youtube-Shorts
        # - Enhancer for YouTube
        # - Control Panel for Twitter
        # - uBlacklist
        # - Plamo Translate
        # - FoxScroller
        # - LeechBlock NG
        # - User-Agent Switcher
      ];

      settings = {
        # Privacy settings
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # Disable telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;

        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };
}

{
  pkgs,
  inputs,
  ...
}: let
  # Helper function to create Firefox extensions from XPI files
  mkFirefoxExtension = {
    name,
    src,
  }:
    pkgs.stdenv.mkDerivation {
      inherit name src;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}
        cp $src $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${name}
      '';
    };
in {
  # ===========================
  # Zen Browser Configuration
  # ===========================
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # Search engine
      search = {
        default = "ddg";
        force = true;
      };

      # Extensions (Firefox Add-ons)
      # Using direct XPI URLs from Mozilla Add-ons
      extensions.packages = [
        # uBlock Origin
        (mkFirefoxExtension {
          name = "ublock-origin@mozilla.org.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            sha256 = "1kvj2kwwiih7yqiirqha7xfvip4vzrgyqr4rjjhaiyi5ibkcsnvq";
          };
        })
        # Dark Reader
        (mkFirefoxExtension {
          name = "addon@darkreader.org.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            sha256 = "1gj455hd0nw2idssbs7cmpxkg1kbjafq18n718rfx0yg5wpl46i6";
          };
        })
        # Hide YouTube-Shorts
        (mkFirefoxExtension {
          name = "hideyoutubeshorts@mozilla.org.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/hide-youtube-shorts/latest.xpi";
            sha256 = "051pgzsmd2yic8n9d435h6d0j0scw50rkp5hbi2bs7lb903s0c3g";
          };
        })
        # Enhancer for YouTube
        (mkFirefoxExtension {
          name = "{dc8f61e1-cdc3-4ed7-9028-222b53cf895f}.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/latest.xpi";
            sha256 = "1zps29ss8nmp3a8k4042rwzx9y3jpivhnjy4qpd44gi7826nmv0y";
          };
        })
        # Control Panel for Twitter
        (mkFirefoxExtension {
          name = "{a35cf3ba-4850-4228-938f-6aa981c37dcc}.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/control-panel-for-twitter/latest.xpi";
            sha256 = "07cgjbavi3axpj9slp27nfiyc5967z3mih3isjdsjjarza4i93vl";
          };
        })
        # uBlacklist
        (mkFirefoxExtension {
          name = "uBlacklist@mozilla.org.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/ublacklist/latest.xpi";
            sha256 = "1ghifsr2g4068karymrvipfbsgwsxz65q0hb8wfm6bh4g7wfgqpn";
          };
        })
        # Plamo Translate
        (mkFirefoxExtension {
          name = "{fddda36b-1927-4a54-ab54-6e2f5c3e5a1e}.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/plamo-translate/latest.xpi";
            sha256 = "0zg9p878givx0mzakdmb4va0vyzxj2x87mbz7cmkx82kgxflv254";
          };
        })
        # FoxScroller
        (mkFirefoxExtension {
          name = "foxscroller@mozilla.org.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/foxscroller/latest.xpi";
            sha256 = "1r02m9kqhl7azfnwrikxlfxgima864yfpzxg8ywplv8wadhdzqvn";
          };
        })
        # LeechBlock NG
        (mkFirefoxExtension {
          name = "leechblockng@protonmail.com.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/leechblock-ng/latest.xpi";
            sha256 = "1rf1p27xr49wlzxcyp8j3g33fcjk5c07z5b68wlgwllszp66cd8k";
          };
        })
        # User-Agent Switcher
        (mkFirefoxExtension {
          name = "{dc572301-7619-461c-a073-cc513a434ddf}.xpi";
          src = pkgs.fetchurl {
            url = "https://addons.mozilla.org/firefox/downloads/latest/uaswitcher/latest.xpi";
            sha256 = "0pvw48524dr6z4d74w51q13m1dn3aaj7v5h24zfyhmx5qqrwp8pd";
          };
        })
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

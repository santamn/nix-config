{
  pkgs,
  inputs,
  ...
}: {
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
      extensions.packages = with pkgs.firefoxAddons; [
        ublock-origin
        darkreader
        hide-youtube-shorts
        enhancer-for-youtube
        control-panel-for-twitter
        ublacklist
        plamo-translate
        foxscroller
        leechblock-ng
        uaswitcher
      ];

      settings = {
        # optional: without this the addons need to be enabled manually after first install
        "extensions.autoDisableScopes" = 0;

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

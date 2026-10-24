{
  inputs,
  ...
}: {
  flake.modules.nixos.firefox = {

  };
  flake.modules.homeManager.firefox = {pkgs, config, ...}: {
    programs.firefox =
      let
        genericSettings = {
          "app.update.auto" = false;
          "browser.aboutConfig.showWarning" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "svg.context-properties.content.enabled" = true;
          "fission.autostart" = true;
          "gfx.webrender.all" = true;
        };
      in
        {
          enable = true;
          configPath = "${config.xdg.configHome}/mozilla/firefox";

          profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            settings = {
            }
            // genericSettings;
          };
          profiles."i2p" = {
            id = 1;
            name = "i2p";
            isDefault = false;
            settings = {
              "network.proxy.type" = 1;
              "network.proxy.http" = "[fc00::2]";
              "network.proxy.http_port" = 4444;
              "network.proxy.ssl" = "[fc00::2]";
              "network.proxy.ssl_port" = 4444;
              "network.proxy.no_proxies_on" = "[::1], localhost";
              "media.peerconnection.ice.proxy_only" = true;
              "keyword.enabled" = false;
            }
            // genericSettings;
          };
        };
    xdg.mimeApps = {
      associations.added = {
        "text/html" = [ "firefox.desktop" ];
      };
      defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
      };
      associations.removed = {
        "text/html" = [ "wine-extension-htm.desktop" ];
      };
    };
  };
}

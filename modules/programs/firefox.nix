# home.nix
{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    programs.firefox = {
      enable = true;
      profiles.manas = {
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
        };
        search.force = true;

        bookmarks = {
          force = true;
          settings = [
            {
              name = "wikipedia";
              tags = ["wiki"];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
          ];
        };
        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
        };

        userChrome = ''
          /* some css */
        '';

        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          # bitwarden
          ublock-origin
          sponsorblock
          darkreader
          # tridactyl
          youtube-shorts-block
          violentmonkey
        ];
      };
    };
  };
}

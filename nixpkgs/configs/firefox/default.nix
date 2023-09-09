{ config, pkgs, ... }:
{
    nixpkgs.config.packageOverrides = pkgs: {
         nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
             inherit pkgs;
         };
    };
    programs.browserpass.enable = true;
    programs.firefox = {
        enable = true;
        profiles.default.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            tridactyl
            buster-captcha-solver
            tree-style-tab
            search-by-image
            return-youtube-dislikes
            browserpass
            libredirect
            terms-of-service-didnt-read
            ublacklist
            dearrow
            # sponsorblock
            # enhancer-for-youtube
            # fastforward
            # furiganaize
            # native-mathml
            old-reddit-redirect
            # ReviewMeta
            # Universal Bypass
            don-t-fuck-with-paste
            redirector
            consent-o-matic
            localcdn
        ];
        profiles.default = {
            id = 0;
            name = "home-manager";
            search = {
                default = "DuckDuckGo";
            };
            userContent = ''
                /* hides the native tabs */
                #TabsToolbar {
                  visibility: collapse;
                }
            '';
        };
    };
}

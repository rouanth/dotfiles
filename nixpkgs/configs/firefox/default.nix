{ config, pkgs, ... }:
{
    nixpkgs.config.packageOverrides = pkgs: {
         nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
             inherit pkgs;
         };
    };
    programs.firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            tridactyl
            buster-captcha-solver
            tree-style-tab
            return-youtube-dislikes
            browserpass
            # enhancer-for-youtube
            old-reddit-redirect
            # ReviewMeta
            # Universal Bypass
        ];
        profiles.default = {
            id = 0;
            name = "home-manager";
            search = {
                default = "DuckDuckGo";
            };
        };
    };
}

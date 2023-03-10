{ config, pkgs, ... }:
{
    imports = [
        ../common
        ../../configs/programming/haskell
        ../../configs/kakoune
        ../../configs/firefox
        ../../configs/latex
        ../../configs/text
        ../../configs/downloaders
        # ../../configs/games
        ../../configs/creative
        ../../configs/sway
        ../../configs/media-viewers
        ../../configs/media-editors
        ../../configs/fonts
        ../../configs/util
        ../../configs/file-browser
    ];
    home.packages = with pkgs; [
        yubikey-personalization-gui
        tagainijisho
        newsboat
        neomutt
        rmlint
        findimagedupes
        instaloader
        android-tools
        android-file-transfer
    ];
    nixpkgs.config.allowUnfree = true;
}

{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        mpv
        zathura
        imv
        yt-dlp
        koreader
    ];
}

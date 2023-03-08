{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        mpv
        zathura
        swayimg
        yt-dlp
        koreader
    ];
}

{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        megatools
        you-get
        yt-dlp
    ];
}



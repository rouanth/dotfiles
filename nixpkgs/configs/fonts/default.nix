{ config, pkgs, ... }:
{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        font-awesome # i3status-rs
        ipafont # Japanese
        ibm-plex # coding font
    ];
}

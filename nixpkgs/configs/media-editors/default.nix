{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        gimp
        audacity
        libreoffice
        inkscape
        # sonic-visualiser
    ];
}

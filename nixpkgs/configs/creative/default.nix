{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        inkscape
        gimp
        krita
        blender
        godot
        gnuplot
        audacity
        xournalpp
    ];
}

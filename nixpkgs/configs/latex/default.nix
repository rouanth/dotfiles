{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        texlab
        texlive.combined.scheme-full
    ];
}



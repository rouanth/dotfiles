{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        tlaplusToolbox
    ];
}


{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        par
        obsidian
        abook
        aspellDicts.ru
        aspellDicts.en
        dos2unix
        sdcv
    ];
}


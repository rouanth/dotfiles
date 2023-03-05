{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        par
        obsidian
        abook
        aspellDicts.ru
        aspellDicts.en
        languagetool
        dos2unix
        sdcv
    ];
}


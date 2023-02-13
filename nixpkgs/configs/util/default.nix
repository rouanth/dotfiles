{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        j
        calc
        ncdu
        fzf
        highlight
        difftastic
        git
        vim
        helix
        pwgen
        pdfgrep
        ripgrep
        jq
    ];
}


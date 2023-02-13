{ config, pkgs, ... }:
{
    imports = [
        ../../machines/current
    ];
    home.packages = with pkgs; [
        fzf
        git
        helix
    ];
}

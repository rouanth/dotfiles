{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        pdfpc
        xournalpp
    ];
}

{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        flex
        nasm
        gcc_multi
        dosbox
        dosemu
        cmake
        aflplusplus
        apitrace
        strace
        automake
        autoconf
        rr
        gdb
        dhex
        ghidra
        radare2
    ];
}

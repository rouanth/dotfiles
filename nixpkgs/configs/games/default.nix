{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # games
        srb2
        mari0
        alephone-marathon
        alephone-durandal
        alephone-infinity
        prboom-plus
        arx-libertatis
        openmw
        nethack
        sgtpuzzles
        dwarf-fortress
        cataclysm-dda

        # installers
        steam-tui
        lgogdownloader
        innoextract
        itch
        butler

        # emulators
        mupen64plus
        fceux
        scummvm
        dosbox
        # retroarchFull
        retroarch
        libretro.scummvm
        libretro.nestopia
        libretro.genesis-plus-gx
        mednaffe

        # tools
        gamemode
        gamescope
        protontricks
    ];
}

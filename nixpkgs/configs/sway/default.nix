{ config, pkgs, lib, ... }:
{
    programs.mako.enable = true;
    services.gammastep = {
        enable = true;
        temperature = {
            day = 6000;
            night = 4000;
        };
        provider = "geoclue2";
    };
    wayland.windowManager.sway = {
        enable = true;
        config = rec {
            modifier = "Mod4";
            terminal = "foot";
            startup = [
                {command = "/usr/lib/geoclue-2.0/demos/agent";}
                {command = "${pkgs.mako}/bin/mako";}
            ];
            bars = [{
                statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
            }];
            input = {
                "type:keyboard" = {
                    xkb_layout = "dvorak,ru";
                    xkb_options = "grp:win_space_toggle,ctrl:nocaps,grp_led:caps,compose:rctrl";
                };
            };
            keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
             in lib.mkOptionDefault {
                "${modifier}+z" = "exec swaylock";
                "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
                "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
                "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "XF86MonBrightnessDown" = "exec brightnessctl set 3%-";
                "XF86MonBrightnessUp" = "exec brightnessctl set 3%+";
                "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl prev";
                "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
                "${modifier}+Shift+x" = "floating toggle";
                "${modifier}+grave" = "scratchpad show";
                "${modifier}+n" = "exec ${pkgs.mako}/bin/makoctl dismiss";
                "${modifier}+Shift+n" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";
                "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen";
                "Ctrl+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy screen";
                "Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area";
                "Ctrl+Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area";
            };
        };
        extraConfig = ''
            exec --no-startup-id alacritty --config-file ~/.config/alacritty/scratchterm.yml -t scratchterm
            for_window [title="scratchterm"] move container to scratchpad
            output "*" bg /home/rouanth/Private/wallpaper.jpg fill
        '';
    };
    home.packages = with pkgs; [
        wl-clipboard
    ];
}


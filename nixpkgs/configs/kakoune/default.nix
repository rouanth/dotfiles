{ config, pkgs, ... }:
{
    programs.kakoune = {
        enable = true;
        config = {
            tabStop = 8;
            keyMappings = [
                {
                    mode = "user";
                    docstring = "LSP mode";
                    key = "l";
                    effect = "%{: enter-user-mode lsp<ret>}";
                }
            ];
            hooks = [
                {
                    name = "WinSetOption";
                    option = "filetype=(rust|haskell|c|cpp|latex)";
                    commands = "lsp-enable-window";
                }
                {
                    name = "WinSetOption";
                    option = "filetype=rust";
                    commands = "set buffer formatcmd 'rustfmt'";
                }
                {
                    name = "WinSetOption";
                    option = "filetype=haskell";
                    commands = "set buffer lintcmd 'hlint'";
                }
                {
                    name = "WinSetOption";
                    option = "filetype=mail";
                    commands = ''
                        set buffer autowrap_column 72
                        autowrap-enable
                    '';
                }
            ];
        };
        plugins = [
            pkgs.kakounePlugins.kak-lsp
        ];
        extraConfig = ''
            eval %sh{kak-lsp --kakoune -s $kak_session}

            hook global BufNewFile .*\.hs %{
                evaluate-commands %sh{
                    file="''${kak_buffile##*/src/}"
                    if [ "$file" != "''${kak_buffile}" ]; then
                        name=$(printf "%s\n" "''${file%%.hs}" | tr '/' '.')
                        echo "execute-keys imodule<space>''${name}<space>where"
                    fi
                }
            }

            addhl global/ column 80 default,rgb:404040
        '';
    };
}

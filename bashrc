if [ -z "${TMUX:-}" ] && which tmux 2> /dev/null; then
	tmux
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
fi

if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi

##### COLOR LIST #############################################################

# Reset
Color_Off='\e[0m'

# Regular Colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# Bold
BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BPurple='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

# Underline
UBlack='\e[4;30m'
URed='\e[4;31m'
UGreen='\e[4;32m'
UYellow='\e[4;33m'
UBlue='\e[4;34m'
UPurple='\e[4;35m'
UCyan='\e[4;36m'
UWhite='\e[4;37m'

# Background
On_Black='\e[40m'
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Purple='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'

# High Intensity
IBlack='\e[0;90m'
IRed='\e[0;91m'
IGreen='\e[0;92m'
IYellow='\e[0;93m'
IBlue='\e[0;94m'
IPurple='\e[0;95m'
ICyan='\e[0;96m'
IWhite='\e[0;97m'

# Bold High Intensity
BIBlack='\e[1;90m'
BIRed='\e[1;91m'
BIGreen='\e[1;92m'
BIYellow='\e[1;93m'
BIBlue='\e[1;94m'
BIPurple='\e[1;95m'
BICyan='\e[1;96m'
BIWhite='\e[1;97m'

# High Intensity backgrounds
On_IBlack='\e[0;100m'
On_IRed='\e[0;101m'
On_IGreen='\e[0;102m'
On_IYellow='\e[0;103m'
On_IBlue='\e[0;104m'
On_IPurple='\e[0;105m'
On_ICyan='\e[0;106m'
On_IWhite='\e[0;107m'

##### PROMPT #################################################################

function generatePrompt {
        ERR=$?
        local arrowColor
        local hostColor
        if [[ "$EUID" -eq 0 ]]; then
                arrowColor="\[$BRed\]"
                hostColor="\[$Purple\]"
        else
                arrowColor="\[$BBlue\]"
                hostColor="\[$Cyan\]"
        fi

        PS1="$arrowColor( $hostColor\h\[$Color_Off\] : \[$Green\]\W "
        if [[ $ERR = "0" ]]; then
                PS1+="$arrowColor)"
        else
                PS1+="\[$BPurple\]€$arrowColor"
        fi

        PS1+="→ \[$Color_Off\]"
}

PROMPT_COMMAND="generatePrompt"

##### SENSIBLE UTILITIES #####################################################

set -e

sensible() {
        local p
        for p in "$@"; do
                if type $(printf "%s" "$p" | cut -d' ' -f1) > /dev/null 2>&1
                then
                       printf "%s" "$p"
                       return 0
               fi
       done
       return 1
}

PAGER=$(sensible 'less -iR' more cat)
VISUAL=$(sensible kak nvim vim vi 'emacs -nw' nano)
EDITOR=$VISUAL
export PAGER
export VISUAL
export EDITOR

if [ -n "$DISPLAY" ]
then
        export TERMINAL="$(sensible alacritty st urxvt xterm)"
        export BROWSER="$(sensible iceweasel firefox qutebrowser)"
else
        export TERMINAL="fbterm"
        export BROWSER="$(sensible lynx elinks links)"
fi

PATH="$HOME/.local/bin:$PATH"
if [ -d "$HOME/.opam/default/bin" ]; then
	PATH=$PATH:$HOME/.opam/default/bin
fi

##### HELPER FUNCTIONS #######################################################

texwatch() {
  x="$1"
  if [ ! -f "$x" -a ! -f "$x.tex" -a ! -f "$x.pdf" ]; then
    echo "Not a file: $x" >&2
    return
  fi
  [ "${x##*.}" != pdf -a "${x##*.}" != tex ] || x="${x%.*}"
  zathura "${x}.pdf" &
  while true; do
    inotifywait -e MODIFY "${x}.tex"
    if [ -f Makefile ]
    then
      make
    else
      pdflatex -shell-escape "${x}.tex"
    fi
  done
}

##### ALIASES ################################################################

alias man="env \
        LESS_TERMCAP_mb='$(printf "$IPurple")' \
        LESS_TERMCAP_md='$(printf "$BYellow")' \
        LESS_TERMCAP_me='$(printf "$Color_Off")' \
        LESS_TERMCAP_se='$(printf "$Color_Off")' \
        LESS_TERMCAP_so='$(printf "$On_IBlue")' \
        LESS_TERMCAP_ue='$(printf "$Color_Off")' \
        LESS_TERMCAP_us='$(printf "$UCyan")' \
        man"

alias fbmplayer='mplayer -vo fbdev2 -fs -really-quiet'
alias ls='ls -CF --color=auto'
alias grep='grep --color=auto'
alias eof='grep -q . -- '
duh() { du -hd 1 --all "$@" | sort -h; }

if type sdcv 2> /dev/null > /dev/null; then
        define() { sdcv -n --color "$@" | less -R; }
fi

alias run_presentation_console='(pixelsize=24;
	urxvt  	-fn "xft:DejaVu Sans Mono:pixelsize="$pixelsize \
		-fb "xft:DejaVu Sans Mono:bold:pixelsize="$pixelsize \
		-fg white -bg black -e env bash --norc --noprofile)'

##### FIXING XDG INCOMPATIBILITY #############################################
# See https://wiki.archlinux.org/index.php/XDG_Base_Directory

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if type abook 2> /dev/null > /dev/null; then
	alias abook='abook \
		--config "$XDG_CONFIG_HOME"/abook/abookrc \
		--datafile "$XDG_DATA_HOME"/abook/addressbook'
fi

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export STACK_ROOT="$XDG_DATA_HOME"/stack

if type gcalcli 2> /dev/null > /dev/null; then
	alias gcalcli='gcalcli --configFolder ~/.config/gcalcli'
fi

if type less 2> /dev/null > /dev/null; then
	alias less='LESSHISTFILE=- less'
fi

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export LEDGER_FILE="$XDG_DATA_HOME"/hledger.journal

if type ipython 2> /dev/null > /dev/null; then
	export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
	export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
fi

if type java 2> /dev/null > /dev/null; then
	export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
fi

if type mednafen 2> /dev/null > /dev/null; then
	export MEDNAFEN_HOME="$XDG_CONFIG_HOME"/mednafen
fi

##### LOCAL DEFINITIONS ######################################################

if [ -r ~/'.bashrc.local' ]; then
        . ~/'.bashrc.local'
fi

set +e

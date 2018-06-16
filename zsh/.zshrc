#!/bin/bash
export LANG="en_US.UTF-8"
SAVEHIST=10
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS 
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

export PATH="/usr/lib/ccache/bin/:$PATH"
 
export TERM="xterm-termite"
#if [[ $TERM == xterm-termite ]]; then
#  . /etc/profile.d/vte.sh
#  __vte_osc7
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerline"
POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="/usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme"
#ZSH_THEME="themes/powerlevel9k/powerlevel9k.zsh-theme"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon time vcs context dir rbenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator)
POWERLEVEL9K_OS_ICON_BACKGROUND="99"
POWERLEVEL9K_OS_ICON_FOREGROUND="0"
POWERLINE_DISABLE_RPROMPT="true"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_NO_BLANK_LINE="true"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

autoload -Uz promptinit
promptinit
BROWSER=/usr/bin/firefox-nightly

#. ~/.config/bspwm/z.sh
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
bindkey '^R' fzf-history-widget  

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

QT_LOGGING_RULES='*=false'
export QT_LOGGING_RULES

export POWERLINE_HIDE_USER_NAME=1 
export POWERLINE_PATH="short"
export MICRO_TRUECOLOR=1
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
searchfunction() {
  echo $(ag -g $1 --smart-case --hidden)
  echo $(ag --smart-case --hidden -l $1)
}

w3mimg () { w3m -o imgdisplay=/usr/lib/w3m/w3mimgdisplay $1}

alias search=searchfunction
source /usr/share/oh-my-zsh/oh-my-zsh.sh
#source $ZSH/zsh-interactive-cd.plugin.zsh
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source aliases
ALIASFILE=~/.aliasesrc
source $ALIASFILE
function add_alias() {
    if [[ -z $1 || -z $2 || $# -gt 2 ]]; then
        echo usage:
        echo "\t\$$0 ll 'ls -l'"
    else
        echo "alias $1='$2'" >> $ALIASFILE
        echo "alias ADDED to $ALIASFILE"
    fi
    source $ALIASFILE
}
export NVM_DIR="/home/steve/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#export EDITOR="micro"

mdcd () {
  mkdir "$1"
  cd "$1"
}

catl () {
    echo "########################################"
    Z=`locate $1 | head -n1`
    echo $Z
    echo "########################################"    
    echo .
    cat $Z
}

bsp () {
  cd ~/.config/bspwm
}

bspa () {
  cd ~/.config/bspwm
  micro autostart
}

bspb () {
  cd ~/.config/bspwm
  micro bspwmrc
  ./bspwmrc
}  

bsps () {
  cd ~/.config/bspwm
  ### Edit file ####
  micro ~/.config/bspwm/sxhdrc/sxhkdrc
  
  ### Reload sxhkd and send a message  ####
  pkill -USR1 -x sxhkd
  notify-send -t 1500 "sxhkd reset"

  ## Get proper copies of symlinked files ####
  #cp ~/.config/sxhkd/sxhkdrc sxhkdrc-copy
  #cp ~/.config/compton.conf compton/compton.conf-copy

  ## Tidy Backup files ###
  rm -rf *~
  
  ## Update my git repo #####
  echo -n "Update Git? " 
  local temp=$1
  read temp
  if [[ $temp = "y" || $temp = "Y" ]]; then
     ~/.config/bspwm/scripts/gitup.sh
  fi  
}  

bspf () {
   cd ~/.config/bspwm
   micro panel/fbpanel.conf
   pkill -USR1 -x fbpanel
}

bspx () {
   cd ~/.config/bspwm
   micro xcape/my-xcape.sh
   echo -n "Restart xcape? " 
   local temp=$1
   read temp
   if [[ $temp = "y" || $temp = "Y" ]]; then
      ~/.config/bspwm/xcape/my-xcape.sh
   fi  
}

change () {
  pushd
  bsp
  echo -n "Update Git? " 
  local temp
  read temp
  if [[ $temp = "y" || $temp = "Y" ]]; then
     ~/.config/bspwm/gitup.sh
  fi
  popd
}

test () {
  
  echo -n "steve0"
  local temp=$1
  read temp
  echo -n "steve"
}

alias lll="tyls "

# fkill - kill process using fzf.
# more great examples how fzf can be used: https://github.com/junegunn/fzf/wiki/examples
function fkill {
  local pid
  pid=$(ps -ef | sed 1d | fzf -e -m -i +s --reverse --tac --margin=4%,1%,1%,2% --inline-info --header="TAB to (un)select. ENTER to kill selected process(es). ESC or CTRL+C to quit." --prompt='Enter string to filter history > ' | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf -e +s --tac | sed 's/ *[0-9]* *//' | sed 's/ *[*]* *//')
}

fd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux --reverse` \
    && cd "$DIR"
}

fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m --reverse -e +s) && cd "$dir"
}

falias() {
  cat .aliasesrc | fzf -e -1 --reverse
}

alias sxs="pkill -USR1 -x sxhkd"

export PATH=$PATH:/root/.gem/ruby/2.4.0/bin:/home/steve/.gem/ruby/2.4.0/bin 
PATH="/home/steve/perl5/bin${PATH:+:${PATH}}"; export PATH;
PATH="/home/steve/.local/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/steve/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/steve/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/steve/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/steve/perl5"; export PERL_MM_OPT;


#export XZ_OPT="--threads=0"
export DEFAULT_USER="steve"
source $ZSH/themes/$ZSH_THEME.zsh-theme
# key bindings
#bindkey "\e[1~" beginning-of-line
#bindkey "\e[4~" end-of-line
#bindkey "\e[5~" beginning-of-history
#bindkey "\e[6~" end-of-history
#bindkey "\e[3~" delete-char  
#bindkey "\e[2~" quoted-insert
#bindkey "\e[5C" forward-word
#bindkey "\eOc" emacs-forward-word
#bindkey "\e[5D" backward-word
#bindkey "\eOd" emacs-backward-word
#bindkey "\ee[C" forward-word
#bindkey "\ee[D" backward-word
#bindkey "^H" backward-delete-word
# for rxvt
#bindkey "e[8~" end-of-line
#bindkey "e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
#bindkey "eOH" beginning-of-line
#bindkey "eOF" end-of-line
# for freebsd console
#bindkey "e[H" beginning-of-line
#bindkey "e[F" end-of-line
# completion in the middle of a line
#bindkey '^i' expand-or-complete-prefix

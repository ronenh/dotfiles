# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return


# Set less options
if [[ -x $(which less) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    export LESSHISTFILE='-'
    if [[ -x $(which lesspipe.sh) ]]
    then
    LESSOPEN="| lesspipe.sh %s"
    export LESSOPEN
    fi
fi

# Set default editor
if [[ -x $(which vim) ]]
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

# FAQ 3.10: Why does zsh not work in an Emacs shell mode any more?
# http://zsh.sourceforge.net/FAQ/zshfaq03.html#l26
#[[ $EMACS = t ]] && unsetopt zle

# Zsh settings for history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Zsh spelling correction options
setopt CORRECT

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
#setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER

# Don’t nice background processes
setopt NO_BG_NICE

# Watch other user login/out
watch=notme
export LOGCHECK=60

# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors` ]]; then
    eval `dircolors ~/.vim/dircolors-solarized/dircolors.ansi-light`
    alias 'ls=ls --color=auto'
    fi
fi

# Why is the date American even when the locale is en_GB?  Fix with this
#export TIME_STYLE="long-iso"

# Short command aliases
alias 'l=ls'
alias 'la=ls -Ah'
alias 'll=ls -lh'
alias 'lq=ls -Q'
alias 'lr=ls -R'
alias 'lrs=ls -lrS'
alias 'lrt=ls -lrt'
alias 'lrta=ls -lrtA'
alias 'lrth=ls -lrth'
alias 'lrtha=ls -lrthA'
alias 'tf=tail -F'
alias 'grep=grep --colour'
alias 'vnice=nice -n 20 ionice -c 3'

# Play safe!
#alias 'rm=rm -i'
#alias 'mv=mv -i'
#alias 'cp=cp -i'

# For convenience
alias 'mkdir=mkdir -p'
alias 'dus=du -ms * | sort -n'

# Typing errors...
alias 'cd..=cd ..'

# Global aliases (expand whatever their position)
#  e.g. find . E L
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g N='> /dev/null'
#alias -g E='2> /dev/null'


# Automatically background processes (no output to terminal etc)
alias 'z=echo $RANDOM > /dev/null; zz'
zz () {
    echo $*
    $* &> "/tmp/z-${1:gs/\//_}-$RANDOM" &!
}

# Aliases to use this
# Use e.g. 'command gv' to avoid
for i in acroread akregator amarok ario chromium-browser easytag eclipse firefox gimp gpdf gv \
    gwenview k3b kate konqueror kwrite libreoffice okular \
    opera; do
    alias "$i=z $i"
done
alias "lo=z libreoffice"

# Quick find
f() {
    echo "find . -iname \"*$1*\""
    find . -iname "*$1*"
}

cd . &> /dev/null
# Print some stuff
date
if [[ -x `which fortune` ]]; then
    echo
    fortune -a 2> /dev/null
    echo
fi

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _match
zstyle ':completion:*' completions 0
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 0
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '' '' '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' substitute 0
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Username completion.
# Delete old definitions
zstyle -d users
# Set explicitly:   zstyle ':completion:*' users mrb04 matt
# Uses /etc/passwd, minus these entries:
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data \
    avahi Debian-exim hplip list cupsys haldaemon ntpd proftpd statd

# Hostname completion
#zstyle ':completion:*' hosts $( cat $HOME/.hosts* )

# File/directory completion, for cd command
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found' '(*/)#CVS'
#  and for all commands taking file arguments
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'

# Prevent offering a file (process, etc) that's already in the command line.
zstyle ':completion:*:(rm|cp|mv|kill|diff|scp):*' ignore-line yes
# (Use Alt-Comma to do something like "mv abcd.efg abcd.efg.old")

# Completion selection by menu for kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Filename suffixes to ignore during completion (except after rm command)
# This doesn't seem to work
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro' '*~'
zstyle ':completion:*:(^rm):*' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro' '*~'
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
#zstyle ':completion:*:(all-|)files' file-patterns '(*~|\\#*\\#):backup-files' 'core(|.*):core\ files' '*:all-files'

zstyle ':completion:*:*:rmdir:*' file-sort time

zstyle ':completion:*' local matt.blissett.me.uk /web/matt.blissett.me.uk

# CD to never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

## Use cache
# Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian
# packages)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Quick ../../..
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
    else
    LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

autoload zsh/sched

# Copys word from earlier in the current command line
# or previous line if it was chosen with ^[. etc
autoload copy-earlier-word
zle -N copy-earlier-word
bindkey '^[,' copy-earlier-word

# Cycle between positions for ambigous completions
autoload cycle-completion-positions
zle -N cycle-completion-positions
bindkey '^[z' cycle-completion-positions

# Increment integer argument
autoload incarg
zle -N incarg
bindkey '^X+' incarg

# Write globbed files into command line
autoload insert-files
zle -N insert-files
bindkey '^Xf' insert-files

# Play tetris
#autoload -U tetris
#zle -N tetris
#bindkey '^X^T' tetris

# xargs but zargs
autoload -U zargs

# Calculator
autoload zcalc

# Line editor
autoload zed

# Renaming with globbing
autoload zmv

# Add Git functions 
#fpath=($fpath ~/.matt-config/zsh-git/functions)
#typeset -U fpath
#setopt promptsubst
#autoload -U promptinit
#promptinit
#prompt wunjo

# Various reminders of things I forget...
# (Mostly useful features that I forget to use)
# vared
# =ls turns to /bin/ls
# =(ls) turns to filename (which contains output of ls)
# <(ls) turns to named pipe
# ^X* expand word
# ^[^_ copy prev word
# ^[A accept and hold
# echo $name:r not-extension
# echo $name:e extension
# echo $xx:l lowercase
# echo $name:s/foo/bar/

# Quote current line: M-'
# Quote region: M-"

# Up-case-word: M-u
# Down-case-word: M-l
# Capitilise word: M-c

# kill-region

# expand word: ^X*
# accept-and-hold: M-a
# accept-line-and-down-history: ^O
# execute-named-cmd: M-x
# push-line: ^Q
# run-help: M-h
# spelling correction: M-s

# echo ${^~path}/*mous*

# Add host/domain specific zshrc
if [ -f $HOME/.zshrc-$HOST ]
then
    . $HOME/.zshrc-$HOST
fi

if [ -f $HOME/.zshrc-$(hostname -f) ]
then
    . $HOME/.zshrc-$(hostname -f)
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git coffee python cp autojump pip zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# vi-mode
bindkey -v


function looper_rev() {
    format-looper-data.py --revisionId `git rev-parse $1`;
}
alias rm_testoutput="rm -f stack*; rm -f testJenkinsSummary.json; rm -rf artifacts*; rm -f nosetests*xml; rm -f py*log; ls -1 | grep '^[a-f0-9]\{32\}$' | xargs rm -rf"
alias bower='noglob bower'

alias hist="history | grep $*"
alias sshagent="eval `ssh-agent -s`"
alias looper="echo ssh -i ~/.ssh/support/test-looper ubuntu@$1"
alias ssh_ccache="ssh -i ~/.ssh/support/ccache-user ubuntu@ccache.ufora.com"
alias space="echo !$*!"

export BASE_PATH=$PATH

if [[ `uname -s` == 'Darwin' ]]; then
    export BASE_PYTHONPATH="/usr/local/lib/python-2.7/site-packages:$PYTHONPATH"
    export PYTHONPATH="/Users/ronenh/repo/src:$PYTHONPATH"
    export PATH="$BASE_PATH:/Users/ronenh/repo/src/ufora/scripts"
    export PKG_CONFIG_PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig"
    export ARCHFLAGS="-arch x86_64"
else
    export BASE_PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
    export CCACHE_DIR=$HOME/volumes/ccache
    export CCACHE_COMPILERCHECK=content
    alias tmux="/home/ronenh/local/tmux-1.8/tmux -CC $*"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    pp() {
        export PYTHONPATH=`pwd`
        export PATH=$PYTHONPATH/ufora/scripts:$PATH
        }

    dr() { docker run -t -i --rm=true --volumes-from DATA $* /bin/bash }

    bindkey "^[^[[D" backward-word
    bindkey "^[^[[C" forward-word
fi

function switch_repo() {
    export PATH=`pwd`:$BASE_PATH
    export PYTHONPATH=`pwd`:$BASE_PYTHONPATH
}

PROMPT='%{$fg_bold[red]%}➜ [%?] %{$reset_color%}%2c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%} %{$reset_color%}'
RPROMPT='[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[magenta]%}%m %{$fg[blue]%}%*%{$reset_color%}]'
ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

if [ -f $HOME/.nvm/nvm.sh ]
then
    . $HOME/.nvm/nvm.sh
    nvm use v0.10.28
fi

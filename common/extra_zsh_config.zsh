# Set up the prompt
PS1='%(?.%F{darkgreen}.%F{red})[%1~]$%b%f '

CASE_INSENSITIVE="true"

setopt histignorealldups sharehistory
setopt MENU_COMPLETE
setopt no_list_ambiguous

bindkey -v

alias aud='/home/saifr/progs/audacity-linux-3.6.1-x64.AppImage'
#go
#alias python="/home/saifr/rnd/preply/helper/addons/pythonscript/x11-64/bin/python3.8"
alias slidesetter="libreoffice --accept=\"socket,host=localhost,port=2002;urp;\""
#alias python=python3
#alias s=python3
alias ls="ls -F"
alias sl="ls -F"
alias gdb="gdb --silent"
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export PATH="/home/saifr/progs/zls/zig-out/bin:$PATH"
#export PATH="/home/saifr/.cabal/bin:$PATH"
#export PATH="/snap/bin:$PATH"
#export PATH="/home/saifr/progs/zig-linux-x86_64-0.12.0:$PATH"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit


bindkey "^P" reverse-menu-complete
zstyle ':completion:*' menu yes select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=* l:|=*' 'm:{A-Z}={a-z}'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
alias c="cd"

# opam configuration
[[ ! -r /home/saifr/.opam/opam-init/init.zsh ]] || source /home/saifr/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


#export PATH="/home/saifr/progs/go1.22.3.linux-amd64/go/bin:$PATH"
#export PATH=$PATH:$(go env GOPATH)/bin
#export PATH="/home/saifr/scripts:$PATH"
#export PATH="/home/saifr/progs/mlton-20210117-1.amd64-linux-glibc2.31/bin:$PATH"
#export PATH=$PATH:/home/saifr/progs
export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

unsetopt BEEP

#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#source "$HOME/.cargo/env"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# >>> xmake >>>
#test -f "/home/saifr/.xmake/profile" && source "/home/saifr/.xmake/profile"
# <<< xmake <<<

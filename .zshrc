HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_SPACE
HISTORY_IGNORE="*deploy-main-cluster*"
HISTIGNORE="*deploy-main-cluster*"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
else
  export EDITOR='emacs'
fi

alias emacs='/usr/local/Cellar/emacs/27.2/bin/emacs-27.2 -nw'

alias editsource='emacs ~/.zshrc'
alias updatesource='source ~/.zshrc'


#To build tags of julia language
# -R: recursive
# -e: to be compatible with the-one-editor (emacs)
# use the ctags options for julia
alias ctagsforjulia='/usr/local/Cellar/universal-ctags/HEAD-a20bb99/bin/ctags -R -e --options=/Users/vitornesello/ctags_folder/ctags --totals=yes --languages=julia'
alias ctagsforcpp='/usr/local/Cellar/universal-ctags/HEAD-a20bb99/bin/ctags -R -e --totals=yes --languages=C++'
alias ctags='/usr/local/Cellar/universal-ctags/HEAD-a20bb99/bin/ctags'

export PATH="/Applications/Julia-1.4.app/Contents/Resources/julia/bin/":$PATH

export PATH="/usr/local/bin/aws":$PATH

export JDEV='/Users/vitornesello/.julia/dev'
alias jdev='cd /Users/vitornesello/.julia/dev'

alias gfe='cd /Users/vitornesello/gitCode/galia-front-end/'
alias gbe='cd /Users/vitornesello/gitCode/galia-back-end/'

# Visual Code alias
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'

export ORTOOLS_PATH='/Users/vitornesello/Applications/or-tools/'

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Gurobi
export GUROBI_HOME="/Library/gurobi910/mac64/"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"

autoload -Uz compinit
compinit
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
eval "$(starship init zsh)"
source /Users/vitornesello/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Shortcuts to get information about the system
alias cputemp='sudo powermetrics|grep -i "CPU die temperature"'
alias gputemp='sudo powermetrics|grep -i "GPU die temperature"'
alias fanspeed='sudo powermetrics|grep -i "Fan"'

export HISTTIMEFORMAT="%d/%m/%y %T "
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias mypip="wget -qO- http://ipecho.net/plain | xargs echo"

alias todos="emacs ~/Desktop/todos.md"

export PATH="/usr/local/opt/node@12/bin:$PATH"

. /usr/local/opt/asdf/asdf.sh

function eur2brl() {
    curl -s http://data.fixer.io/api/latest\?access_key\=97e1833fadb1c651d6d468b2e2d7ba91\&format\=1\&base\=EUR | grep BRL | tr -dc '.0-9\n'
}

function wait_and_pull_master() {
	git checkout master
    sleep 240
	git pull
}

export PATH="/usr/local/sbin:$PATH"
export PATH="/Applications/Julia-1.7.app/Contents/Resources/julia/bin/:$PATH"

alias call_oracle='julia ~/.julia/dev/CardsOracle/scripts/call_oracle.jl'
alias print_champs='julia ~/.julia/dev/CardsOracle/scripts/print_championship.jl'

function formatpkg() {
	julia  -e 'using JuliaFormatter; format(".", verbose=true)'
}

# fzf history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height "50%" | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

alias start_minecraft="java -jar server.jar nogui"

# . "$HOME/.cargo/env"

autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/terraform terraform
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
complete -o nospace -C /usr/local/bin/mc mc

# Antigen
source /usr/local/share/antigen/antigen.zsh

# Load Antigen configurations
antigen init ~/.antigenrc

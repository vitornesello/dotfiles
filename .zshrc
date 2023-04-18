HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_SPACE
HISTORY_IGNORE="*deploy-main-cluster*"
HISTIGNORE="*deploy-main-cluster*"
export HISTTIMEFORMAT="%d/%m/%y %T "

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
else
  export EDITOR='emacs'
fi

# Important PATH
export PATH="/opt/homebrew/bin:$PATH" # This must come first in order to use ARM isntallation
export PATH="/usr/local/sbin:$PATH"
export PATH="/Applications/Julia-1.8.app/Contents/Resources/julia/bin/:$PATH"
# I think we can delete node12
export PATH="/usr/local/opt/node@12/bin:$PATH"

# Go binaries
export PATH="/Users/vitornesello/go/bin:$PATH"

# Gurobi
export GUROBI_HOME="/Library/gurobi910/mac64/"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"

# HiGHS
export PATH="${PATH}:~/gitcode/HiGHS/bin/"

# AWS
export PATH="/usr/local/bin/aws":$PATH

# Doom Emacs
PATH="$HOME/.doom/emacs/bin:$PATH"

# Visual Code alias
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'

autoload -Uz compinit
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
eval "$(starship init zsh)"

# # Important aliases
# alias emacs='/usr/local/Cellar/emacs/28.2/bin/emacs-28.2 -nw'

alias editsource='emacs ~/.zshrc'
alias updatesource='source ~/.zshrc'

alias jdev='cd /Users/vitornesello/.julia/dev'
alias gfe='cd /Users/vitornesello/gitcode/galia-front-end/'
alias gbe='cd /Users/vitornesello/gitcode/galia-back-end/'
alias gitcode='cd /Users/vitornesello/gitcode'

# Gadgets
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias mypip="wget -qO- http://ipecho.net/plain | xargs echo"
alias todos="emacs ~/Desktop/todos.md"
alias compresspdf="ps2pdf -dPDFSETTINGS=/ebook original.pdf compressed.pdf"

# Shortcuts to get information about the system
alias cputemp='sudo powermetrics|grep -i "CPU die temperature"'
alias gputemp='sudo powermetrics|grep -i "GPU die temperature"'
alias fanspeed='sudo powermetrics|grep -i "Fan"'

function eur2brl() {
    curl -s http://data.fixer.io/api/latest\?access_key\=97e1833fadb1c651d6d468b2e2d7ba91\&format\=1\&base\=EUR | grep BRL | tr -dc '.0-9\n'
}


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

. "$HOME/.cargo/env"

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/terraform terraform
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# complete -o nospace -C /usr/local/bin/mc mc

# Antigen
source /usr/local/share/antigen/antigen.zsh
antigen init ~/.antigenrc
source /Users/vitornesello/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

. /usr/local/opt/asdf/libexec/asdf.sh


function setdev() {
    export K8SENV=dev-stg
    export AWS_PROFILE=vitornesello
    export KUBECONFIG=/Users/vitornesello/gitCode/infrastructure/development-staging/kubeconfig_development-staging-eks-cluster
    echo "\033[1;92mUsing K8s dev-stg environment\033[00m"
}

function setprod() {
    export K8SENV=production
    export AWS_PROFILE=vitornesello
    export KUBECONFIG=/Users/vitornesello/gitCode/infrastructure/production/kubeconfig_production-eks-cluster
    echo "\033[1;91mUsing K8s production environment\033[00m"
}

function setclear() {
    sed -i 's/colors: *GruvboxLight/colors: *DoomOne/g' ~/.alacritty.yml
}

function setdark() {
    sed -i 's/colors: *DoomOne/colors: *GruvboxLight/g' ~/.alacritty.yml
}

alias lasttag="git describe --tags --abbrev=0"

function ftoken() {
    security find-generic-password -w -s 'vitorkeys'  -a $1
}


function register_package() {
    PKNAME=$1
    echo "Registering package $PKNAME"
    cd ~/.julia/registries/Benders
    git pull
    julia -e "import Pkg; Pkg.activate(\"../../environments/registrator\"); Pkg.develop(\"$PKNAME\"); using LocalRegistry; register(\"$PKNAME\", registry=\".\", repo=\"git@github.com:atoptima/$PKNAME.git\"); Pkg.rm(\"$PKNAME\");"
    echo "Registered package $PKNAME"
}

function ytdl() {
    youtube-dl --extract-audio --audio-format mp3 $1
}

function decrypt() {
    openssl enc -d -aes-256-cbc -in $1 -out $1.txt
}

function encrypt() {
    openssl enc -aes-256-cbc -salt -in $1 -out $1.enc
}

# GBE utilities
PATH="$HOME/gitcode/gbe-cli/target/release/:$PATH"
export GBE_USR=vitornesello@atoptima.com
export GBE_PWD=$(ftoken gbe-pwd)
export GBE_URL=https://gbe.atoptima.com

function job-report() {
    gbe-cli job-report -l 10 | dasel -r json -w csv | column -t -s,
}



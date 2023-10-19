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
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export JAVA_HOME="/usr/local/homebrew/Cellar/openjdk/20.0.1"

# Important PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/Applications/Julia-1.8.app/Contents/Resources/julia/bin/:$PATH"
alias julia19="/Applications/Julia-1.9.app/Contents/Resources/julia/bin/julia"
alias julia110="/Applications/Julia-1.10.app/Contents/Resources/julia/bin/julia"

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

# NVIM
NVIM_FOLDER="~/.config/nvim"

# Visual Code alias
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'

# ASDF
. "$HOME/.asdf/asdf.sh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
eval "$(starship init zsh)"

alias editsource='nvim ~/.zshrc'
alias updatesource='source ~/.zshrc'

alias jdev='cd /Users/vitornesello/.julia/dev'
alias gfe='cd /Users/vitornesello/gitcode/galia-front-end/'
alias gbe='cd /Users/vitornesello/gitcode/galia-back-end/'
alias gitcode='cd /Users/vitornesello/gitcode'

# Gadgets
alias mypip="wget -qO- http://ipecho.net/plain | xargs echo"
alias todos="nvim ~/Desktop/todos.md"
alias compresspdf="ps2pdf -dPDFSETTINGS=/ebook original.pdf compressed.pdf"

# Shortcuts to get information about the system
alias cputemp='sudo powermetrics|grep -i "CPU die temperature"'
alias gputemp='sudo powermetrics|grep -i "GPU die temperature"'
alias fanspeed='sudo powermetrics|grep -i "Fan"'

function eur2brl() {
    curl -s http://data.fixer.io/api/latest\?access_key\=97e1833fadb1c651d6d468b2e2d7ba91\&format\=1\&base\=EUR | grep BRL | tr -dc '.0-9\n'
}

function formatpkg() {
        julia110  -e 'using JuliaFormatter; format(".", verbose=true)'
}

. "$HOME/.cargo/env"

# Antigen
source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
antigen init ~/.antigenrc
source /Users/vitornesello/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

function setlocal() {
    export GBE_URL=http://localhost:3003
    unset K8SENV
    unset AWS_PROFILE
    unset KUBECONFIG
    echo "\033[1;92mUsing local environment\033[00m"
}

function setstg() {
    export GBE_URL=https://gbe.staging.atoptima.com
    export K8SENV=dev-stg
    export AWS_PROFILE=vitornesello
    export KUBECONFIG=~/gitcode/infrastructure/development-staging/kubeconfig_development-staging-eks-cluster
    echo "\033[1;92mUsing K8s dev-stg environment\033[00m"
}

function setdev() {
    export GBE_URL=https://gbe.development.atoptima.com
    export K8SENV=dev-stg
    export AWS_PROFILE=vitornesello
    export KUBECONFIG=~/gitcode/infrastructure/development-staging/kubeconfig_development-staging-eks-cluster
    echo "\033[1;92mUsing K8s dev-stg environment\033[00m"
}

function setprod() {
    export GBE_URL=https://gbe.atoptima.com
    export K8SENV=production
    export AWS_PROFILE=vitornesello
    export KUBECONFIG=~/gitcode/infrastructure/production/kubeconfig_production-eks-cluster
    echo "\033[1;91mUsing K8s production environment\033[00m"
}

alias lasttag="git describe --tags --abbrev=0"

function ftoken() {
    security find-generic-password -w -s 'vitorkeys'  -a $1
}

function updatetoken() {
    security delete-generic-password -s 'vitorkeys'  -a $1
    security add-generic-password -s 'vitorkeys' -a $1 -w $2
}

function atoken() {
    security add-generic-password -s 'vitorkeys' -a $1 -w $2
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

alias cols="dasel -r json -w csv | column -t -s,"

function job-report() {
    gbe-cli report job -l $1 | dasel -r json -w csv | column -t -s,
}

function setdark() {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    export DARK_MODE=1
    sed -i'' -e 's/colors: \*GruvboxLight/colors: \*DoomOne/g' ~/.alacritty.yml
}

function setlight() {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
    unset DARK_MODE
    sed -i'' -e 's/colors: \*DoomOne/colors: \*GruvboxLight/g' ~/.alacritty.yml
}

function pkgcov() {
    julia -e "using LocalCoverage, Pkg; Pkg.develop(\"$1\"); html_coverage(generate_coverage(\"$1\"; run_test = true); open = true, dir = tempdir())"
}

export HOMEBREW_BREWFILE=~/gitcode/dotfiles/Brewfile

function ug-report() {
    gbe-cli report user-group | dasel -r json -w csv | column -t -s, | awk '{print($1, $8, $14, $15)}' | column -t
}

function usage-report() {
    gbe-cli report usage-kpis --start-date 2023-07-31 -a vrp-app -g 11 | jq -r '.[] | [.application_path, .user_group_name, .nb_operations] | @csv' | column -t -s,
    # gbe-cli report usage-kpis -a $1 -g $2 --start-date $3 | jq '[.[].nb_operations] | add'
}

# Setup fzf
# ---------
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_ALT_C_COMMAND='ag --null -g ./ | xargs -0 dirname | sort -u'
if [[ ! "$PATH" == */user/local/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/homebrew/opt/fzf/bin"
fi

# Key bindings
# ------------
source "/usr/local/homebrew/opt/fzf/shell/key-bindings.zsh"

alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

function manger() {
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content": "On va manger!!!"}' https://discord.com/api/webhooks/1162332065665130516/8-dByj8WHKNWYktFiKLhQ_qakf0dO37h-l-vVE4nZ-W4wzz3qIPfYc23w6J3rYHNauIJ
}


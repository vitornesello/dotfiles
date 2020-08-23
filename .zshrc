HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/vitornesello/.oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs-26.3'
else
  export EDITOR='emacs-26.3'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad



### FROM HERE
# alias ls='ls -GFh'

# alias cplex127='/Users/vitornesello/Applications/ILOG/CPLEX_Studio1271/cplex/bin/x86-64_osx/cplex'
# export PATH="$PATH:/Users/vitornesello/Applications/ILOG/CPLEX_Studio1271/cplex/bin/x86-64_osx/cplex":$PATH
# export LD_LIBRARY_PATH="/Users/vitornesello/Applications/ILOG/CPLEX_Studio1271/cplex/bin/x86-64_osx/":$LD_LIBRARY_PATH

alias cplex128='/Users/vitornesello/Applications/ILOG/CPLEX_Studio128/cplex/bin/x86-64_osx/cplex'
export PATH="/Users/vitornesello/Applications/ILOG/CPLEX_Studio128/cplex/bin/x86-64_osx/cplex":$PATH
export LD_LIBRARY_PATH="/Users/vitornesello/Applications/ILOG/CPLEX_Studio128/cplex/bin/x86-64_osx/":$LD_LIBRARY_PATH

# export LD_LIBRARY_PATH="/Users/vitornesello/Applications/gitCode/vroom/":$LD_LIBRARY_PATH
# export DYLD_LIBRARY_PATH="/Users/vitornesello/Applications/gitCode/vroom/":$DYLD_LIBRARY_PATH:$PATH
# export PATH="$PATH:/Users/vitornesello/Applications/gitCode/vroom/bin/"

alias emacs='/usr/local/Cellar/emacs/26.3/bin/emacs-26.3 -nw'


# export PATH="$PATH:/Library/TeX/Root/bin/x86_64-darwin/pdflatex":$PATH
# alias pdflatex='/Library/TeX/Root/bin/x86_64-darwin/pdflatex'


# # BaPCod paths
# export BAPCOD_ROOT=/Users/vitornesello/Applications/BaPCod/BaPCodFramework/2.0.0/BaPCod
# export BAPCOD_PATH=$BAPCOD_ROOT:$BAPCOD_ROOT/include:$BAPCOD_ROOT/include_solvers:$BAPCOD_ROOT/lib:$BAPCOD_ROOT/tools/backtrace:$BAPCOD_ROOT/tools/MathProgSolverBuilder/include:$BAPCOD_ROOT/tools/MathProgSolverBuilder/src:$BAPCOD_ROOT/include_solverInterfaces
# export PATH=$BAPCOD_PATH:$PATH
# # cplex paths used by bapcod
# export CPLEX_INCLUDE_DIR=/Users/vitornesello/Applications/ILOG/CPLEX_Studio1271/cplex/include/ilcplex
# export PATH=$CPLEX_INCLUDE_DIR:$PATH
# export CPLEX_LIBRARY=/Users/vitornesello/Applications/ILOG/CPLEX_Studio1271/cplex/lib/x86-64_osx/static_pic
# export PATH=$CPLEX_LIBRARY:$PATH
# # lemon paths used by bapcod
# export LEMON_INCLUDE_DIR=$BAPCOD_ROOT/tools/lemon-1.3.1/build/include
# export PATH=$LEMON_INCLUDE_DIR:$PATH
# export LEMON_LIBRARY=$BAPCOD_ROOT/tools/lemon-1.3.1/build/lib
# export PATH=$LEMON_LIBRARY:$PATH
# # path to good version of boost
# export Boost_INCLUDE_DIR=$BAPCOD_ROOT/tools/boost_1_56_0/build/include
# export PATH=$Boost_INCLUDE_DIR:$PATH

# # I commented this to see if something breaks...
# # export CPLUS_INCLUDE_PATH=/usr/local/include/


# # MacPorts Installer addition on 2017-06-26_at_19:35:01: adding an appropriate PATH variable for use with MacPorts.
# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# # Finished adapting your PATH environment variable for use with MacPorts.


# #Julia
alias julia06='/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia'
#alias julia07='/Applications/Julia-0.7.app/Contents/Resources/julia/bin/julia'
alias julia10='/Applications/Julia-1.0.5.app/Contents/Resources/julia/bin/julia'
alias julia11='/Applications/Julia-1.1.app/Contents/Resources/julia/bin/julia'
alias julia12='/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia'
alias julia13='/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia'
alias julia14='/Applications/Julia-1.4.app/Contents/Resources/julia/bin/julia'
# When developing Coluna:
# export JULIA_LOAD_PATH=/Users/vitornesello/.julia/dev/GSolver/
# export JULIA_LOAD_PATH=/Users/vitornesello/.julia/dev/EnergisaPrizeCollecting/

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

alias gfe='cd /Users/vitornesello/Applications/gitCode/galia-front-end/'
alias gbe='cd /Users/vitornesello/Applications/gitCode/galia-back-end/'

# Visual Code alias
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'

export ORTOOLS_PATH='/Users/vitornesello/Applications/or-tools/'

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Gurobi
export GUROBI_HOME="/Library/gurobi902/mac64/"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"


# # RUBY GEM CONFIG
# export GEM_HOME=~/.gem/ruby/2.3
# export PATH=$PATH:~/.gem/ruby/2.3/bin

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/vitornesello/Applications/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/vitornesello/Applications/google-cloud-sdk/path.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/vitornesello/Applications/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/vitornesello/Applications/google-cloud-sdk/completion.zsh.inc'; fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz compinit
compinit
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
eval "$(starship init zsh)"
source /Users/vitornesello/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


alias cputemp='sudo powermetrics|grep -i "CPU die temperature"'
alias gputemp='sudo powermetrics|grep -i "GPU die temperature"'
alias fanspeed='sudo powermetrics|grep -i "Fan"'

export HISTTIMEFORMAT="%d/%m/%y %T "
alias fzfp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias mypip="dig +short myip.opendns.com @resolver1.opendns.com"

function todos() {
	tmux split-window -h -p 50 "cd ~/Desktop && emacs todos.md"
}
export PATH="/usr/local/opt/node@12/bin:$PATH"

. /usr/local/opt/asdf/asdf.sh

source /usr/local/share/antigen/antigen.zsh


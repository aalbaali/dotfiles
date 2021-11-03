#source ~/.bashrc
export ZPLUG_HOME=~/.zplug
export ZSH=/home/amro.al-baali/.oh-my-zsh

# Get zplug if it doesn't exist
if [[ ! -d $ZPLUG_HOME ]];then
    git clone https://github.com/b4b4r07/zplug $ZPLUG_HOME
fi

# Source zplug
source $ZPLUG_HOME/init.zsh

# Plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "lib/history", from:oh-my-zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "arzzen/calc.plugin.zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Source plugins
zplug load

# Options
setopt autopushd pushdignoredups

# configure spaceship prompt
SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
#  user          # Username section
#  host          # Hostname section
#  git           # Git section (git_branch + git_status)
#  line_sep      # Line break
  char          # Prompt character
)
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
#SPACESHIP_PROMPT_ADD_NEWLINE=true
#SPACESHIP_PROMPT_SEPARATE_LINE=true
#SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_USER_SHOW=never # When to show user name
SPACESHIP_USER_PREFIX='no '

# Stop prompt from setting tmux title
DISABLE_AUTO_TITLE=true

# Autosuggestion colour
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#707880"
# Autosuggest completion
bindkey '^ ' autosuggest-accept
# Autosuggestion completion and execution ('^M' is the return key)
bindkey '^j' autosuggest-execute

# Aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias l='ls -CF'
alias ta='tmux a -t'
alias now='watch -x -t -n 0.01 date +%s.%N' 
alias o=xdg-open
alias k='k -h'
alias cdg='cd "$(git rev-parse --show-cdup)"'
alias cds='cd "$(git rev-parse --show-superproject-working-tree)"'
alias ja='ninja'
alias ctest='ctest --output-on-failure'
alias cm='cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=On -DCMAKE_BUILD_TYPE=RelWithDebInfo'
alias cmd='cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=On -DCMAKE_BUILD_TYPE=Debug'
alias fd='fdfind'
alias a="apt-cache search '' | sort | cut --delimiter ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xargs -r sudo apt install -y"

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable Ctrl-x to edit command line in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

# Add local to path
export PATH="$HOME/.local/bin:$PATH"

# Make and change into a directory
mkcd()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# Fuzzy checkout git branch with fzf
zb() 
{
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Log CPU and memory usage of a process
logpid() { while sleep 1; do  ps -p $1 -o pcpu= -o pmem= ; done; }

setopt autocd 
autoload -Uz compinit
compinit

source ~/Dev/robot-dev/docker_init.sh &> /dev/null
# Networking alias
# Check https://avidbots.atlassian.net/wiki/spaces/ROBOTSYS/pages/24838213/D
if [ -f ~/avidbots_networking/aliases ]; then
    . ~/avidbots_networking/aliases
fi

# Source localrc
[ -f ~/.localrc ] && source ~/.localrc

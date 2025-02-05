notifySessionStatusAndExitTmux() {
  if [[ "$(tmux ls | grep $sessionId | wc -l)" == "0" ]] ; then
    notify-send -t 10000 --app-name="Tmux" "$sessionId exited"
  else 
    notify-send -t 10000 --app-name="Tmux" "$sessionId detached"
  fi 
  exit
}

if [[ ! -v TMUX ]] ; then
  tmuxls="$(tmux ls)"
  if [ -z $tmuxls ] ; then
    sessionId="session 1"
    tmux -u new -s "session 1" && notifySessionStatusAndExitTmux
  else
    sessionCount="$(echo $tmuxls | wc -l)"
    sessionId=$((sessionCount+1))
    detachedSessionCount="$(echo $tmuxls | grep "(attached)" | wc -l )"
    detachedSessionCount=$((sessionCount-$detachedSessionCount))
    detchedSessionFound=false
    # look for detached session 
    if [[ $detachedSessionCount != "0" ]] ; then 
      while read -r line; do
        if [[ "$(echo $line | grep "attached" | wc -l )" == 0 ]] ; then 
          # found detched session 
          sessionId=$(echo $line|grep -o 'session [0-9a-zA-Z]*')
          detchedSessionFound=true 
        fi 
      done <<< $tmuxls
    fi 
    if [[ $detchedSessionFound == true ]] ; then 
      if [[ "$detachedSessionCount" != "0" ]] ; then
        notify-send -t 10000 --app-name="Tmux" "$detachedSessionCount detached sessions found"
      fi 
      notify-send -t 10000 --app-name="Tmux" "Reattached $sessionId"
      tmux -u attach -t $sessionId && notifySessionStatusAndExitTmux
    fi 
    # look lower number that might be available
    while [ $sessionId -gt 0 ] && [ "$(echo $tmuxls | grep "session $sessionId" | wc -l)" != "0" ] ;
    do 
      sessionId=$((sessionId-1))
    done
    # look for new session number
    if [[ $sessionId == "0" ]] ; then
      sessionId=$((sessionCount+1))
      while [ "$(echo $tmuxls | grep "session $sessionId" | wc -l)" != "0" ] ;
      do 
        sessionId=$((sessionId+1))
      done
    fi
    sessionId="session $sessionId"
    tmux -u new -s $sessionId && notifySessionStatusAndExitTmux
  fi
fi 

if [ ! -d "$HOME/.tmux/plugins/tpm" ] && [ ! -v TMUX ] ; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf
fi

# home brew path export
if [[ ! -d "/home/linuxbrew" ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  clear
fi

export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export HOMEBREW_NO_ENV_HINTS=true

## print info
#if [[ "$(which cowsay)" == "cowsay not found" || "$(which fastfetch)" == "fastfetch not found" || "$(which fortune)" == "fortune not found" || "$(which cowthink)" == "cowthink not found" || "$(which lolcat)" == "lolcat not found" ]] ; then
#  brew install cowthink fortune fastfetch lolcat
#  clear
#fi 
##if [[ "$(which pacstall)" == "pacstall not found" ]] ; then
##  bash -c "sudo bash -c \"\$(curl -fsSL https://pacstall.dev/q/install || wget -q https://pacstall.dev/q/install -O -)\""
##fi
#if [[ "$(( $RANDOM % 2 ))" == "1" ]] ; then 
#  fortune | cowthink > /dev/shm/ascii
#  #fortune | pokemonthink > /dev/shm/ascii
#else 
#  fortune | cowsay > /dev/shm/ascii
#  #fortune | pokemonsay > /dev/shm/ascii
#fi
#fastfetch --file /dev/shm/ascii
##macchina --theme cowthink | lolcat --animate --duration=2 -t
#rm /dev/shm/ascii

fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git adb brew)

source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# eval "$(zoxide init zsh)"
# alias cd='z'

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

source /home/sanjay/dotfiles/scripts/apply.sh
export PATH=$HOME/.local/bin:$PATH
source /home/sanjay/dotfiles/alias

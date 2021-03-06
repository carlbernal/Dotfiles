export ZSH="/home/carlb/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=( \
    git \
    colored-man-pages \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    vi-mode \
)

source $ZSH/oh-my-zsh.sh

# aliases
source ~/.aliases

# python3
export PATH=$HOME/.local/bin:$PATH

# personal bin
export PATH=$HOME/bin:$PATH
export PATH=$HOME/scripts:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/carlb/.sdkman"
[[ -s "/home/carlb/.sdkman/bin/sdkman-init.sh" ]] && source "/home/carlb/.sdkman/bin/sdkman-init.sh"

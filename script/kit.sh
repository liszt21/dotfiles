# utilities
text-in-file() {
    # $1 text
    # $2 file
    [ $1 ] && [ $2 ] && {
        [ ! -e $2 ] && {
            echo "File $2 not exist..."
            exit
        }
        grep "$1" < "$2" >/dev/null 2>&1
    }
}

command-exists() {
	command -v "$@" >/dev/null 2>&1
}

try-source() {
    if [ -f "$1" ]; then source "$1"; fi
}

load-conda() {
    if [ -d "$HOME/.anaconda" ];then
    CONDA_HOME="$HOME/.anaconda"
    fi

    if [ -d "$HOME/.miniconda" ];then
    CONDA_HOME="$HOME/.miniconda"
    fi

    if [ -d "$CONDA_HOME" ] ;then
        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('$CONDA_HOME/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$CONDA_HOME/etc/profile.d/conda.sh" ]; then
                . "$CONDA_HOME/etc/profile.d/conda.sh"
            else
                export PATH="$CONDA_HOME/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<
    fi

    command-exists conda && conda activate
}

load-nvm () {
    if [ -d "$HOME/.nvm" ] ; then
        export NVM_DIR="$HOME/.nvm"
    elif [ -d "$HOME/.config/nvm" ] ; then
        export NVM_DIR="$HOME/.config/nvm"
    fi
    if test $NVM_DIR ; then
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        export NODE_PATH=`npm root -g`
    fi
}

proxy-on () {
    if [ $WIN_HOST ] ;then
        PROXY="http://$WIN_HOST:7890"
    else
        PROXY="http://localhost:7890"
    fi
    export HTTP_PROXY=$PROXY
    export HTTPS_PROXY=$PROXY
    git config --global http.proxy $PROXY
    git config --global https.proxy $PROXY
}

proxy-off () {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

gpg-login() {
    export GPG_TTY=$TTY
    echo "test" | gpg --clearsign > /dev/null 2>&1
}

gpg-logout() {
    echo RELOADAGENT | gpg-connect-agent
}

init-wsl() {
    [ "$WSL_DISTRO_NAME" ] && {
        WIN_HOST=$(ip route | awk '{print $3; exit}')
        export WIN_HOST=$WIN_HOST
        # export LIBGL_ALWAYS_INDIRECT=1
        # export DISPLAY=$WIN_HOST:0
    }
}

init-kit() {
    export KIT_LOADED=true
    init-wsl
    load-conda
    load-nvm
}

try-init-kit() {
    if [ ! $KIT_LOADED ]; then
        init-kit
    fi
}

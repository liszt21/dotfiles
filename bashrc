source "$HOME/Dotfiles/script/kit.sh"
try-init-kit

export GPG_TTY=$(tty)
export GIT_SSL_NO_VERIFY=1

export GUIX_BUILD_OPTIONS="--substitute-urls=https://mirror.sjtu.edu.cn/guix/"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

export EMACSLOADPATH="$EMACSLOADPATH:/usr/share/emacs/site-lisp"

export DOTFILES_HOME="$HOME/Dotfiles"
export PNPM_HOME="$HOME/.local/share/pnpm"
export EMACY_HOME="$DOTFILES_HOME/module/emacy"
export LISUX_HOME="$DOTFILES_HOME/module/lisux"
export PATH=~/.emacs.d/bin:~/.roswell/bin:~/.local/bin:~/.guix-profile/bin:~/.nix-profile/bin:$PNPM_HOME:$EMACY_HOME:$PATH

# Hooks
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
# eval "$(starship init bash)"
# eval "$(conda shell.bash hook)"
# eval "$(emacy hook bash)"

# conda activate

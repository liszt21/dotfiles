source "$HOME/Dotfiles/script/kit.sh"
try-init-kit

# guix
export GUIX_BUILD_OPTIONS="--substitute-urls=https://mirror.sjtu.edu.cn/guix/"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export GUIX_PROFILE="/home/liszt/.guix-profile"
source "$GUIX_PROFILE/etc/profile"

# path
export DOTFILES_HOME="$HOME/Dotfiles"
export PNPM_HOME="$HOME/.local/share/pnpm"
export EMACY_HOME="$DOTFILES_HOME/module/emacy"
export LISUX_HOME="$DOTFILES_HOME/module/lisux"
export PATH=~/.emacs.d/bin:~/.roswell/bin:~/.local/bin:~/.guix-profile/bin:~/.nix-profile/bin:~/.cargo/bin:$PNPM_HOME:$EMACY_HOME:$PATH

# misc
export GPG_TTY=$(tty)
export GIT_SSL_NO_VERIFY=1

# hook
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
eval "$(starship init bash)"
# eval "$(conda shell.bash hook)"
# eval "$(emacy hook bash)"

# conda activate

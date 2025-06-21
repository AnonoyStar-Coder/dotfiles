case $- in
  *i*) ;;
    *) return;;
esac

export OSH='/home/balraj/.oh-my-bash'

OSH_THEME=""

OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source "$OSH"/oh-my-bash.sh

source ~/dotfiles/.bash-alias

eval "$(oh-my-posh init bash --config ~/dotfiles/.theme.omp.json)"



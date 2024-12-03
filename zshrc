# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Make sure completions work
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Go path will always be here
export GOPATH="${HOME}/Code/go"

# Ensure PATH has GOPATH
export PATH="${PATH}:${GOPATH}/bin"

# Oh My ZSH
plugins=(
  kube-ps1
)

export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

# PROMPT='$(kube_ps1)'$PROMPT # or RPROMPT='$(kube_ps1)'
# export KUBE_PS1_PREFIX="<"
export KUBE_PS1_SYMBOL_ENABLE=false
# export KUBE_PS1_SEPARATOR=""
export KUBE_PS1_DIVIDER=" > "
# export KUBE_PS1_SUFFIX=">"

# GPG TTY fix
export GPG_TTY=$(tty)

# profile
[[ -f ~/.profile ]] && source ~/.profile

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

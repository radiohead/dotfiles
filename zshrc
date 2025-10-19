# Skip when running vscode / cursor terminals
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
  return
fi

# Fix GPG TTY overwriting
export GPG_TTY=`tty`

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

# Homebrew
# Force it to be in zhsrc because it's required for other things to work
eval "$(/opt/homebrew/bin/brew shellenv)"

_load_settings "$HOME/.zsh/configs"

# profile
[[ -f ~/.profile ]] && source ~/.profile

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# powerlevel10k shell
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# SCM Breeze
[[ ! -f ~/.scm_breeze/scm_breeze.sh ]] || source ~/.scm_breeze/scm_breeze.sh

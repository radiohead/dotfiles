# Homebrew
#
# Make sure completions work
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# GPG TTY fix
export GPG_TTY=$(tty)


if &compatible
  set nocompatible
end

" Shim command and function to allow migration from Vundle to vim-plug.
function! VundleToPlug(vundle_command, arg, ...)
  echom "You are using Vundle's `".a:vundle_command."` command to declare plugins. Dotfiles now uses vim-plug for plugin management. Please rename uses of `".a:vundle_command."` to `Plug`. Plugin was '".a:arg."'."
  let vim_plug_options = {}

  if a:0 > 0
    if has_key(a:1, 'name')
      let name = a:1.name
      let vim_plug_options.dir = "$HOME/.vim/bundle/".a:1.name
    endif

    if has_key(a:1, 'rtp')
      let vim_plug_options.rtp = a:1.rtp
    endif
  endif

  Plug a:arg, vim_plug_options
endfunction

com! -nargs=+  -bar Plugin call VundleToPlug("Plugin", <args>)
com! -nargs=+  -bar Bundle call VundleToPlug("Bundle", <args>)

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'christoomey/vim-run-interactive'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'janko-m/vim-test'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/tComment'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-rbenv'
Plug 'ivalkeen/vim-ctrlp-tjump'

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

call plug#end()

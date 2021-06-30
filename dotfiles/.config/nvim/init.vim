
call plug#begin('~/.vim/plugged')
	Plug 'lervag/vimtex'
	Plug '907th/vim-auto-save'
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
call plug#end()

set number
set relativenumber

set mouse=a
set clipboard=unnamedplus

set shiftwidth=4

set tabstop=4
set softtabstop=4

set spelllang=en
set spellfile=$HOME/.config/vim/spell.en.utf-8.add

let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 0

let g:netrw_home='~/.cache/vim'

let g:airline_powerline_fonts = 1

" https://stackoverflow.com/questions/5312235/how-do-i-correct-vim-spelling-mistakes-quicker
imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

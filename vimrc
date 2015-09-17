execute pathogen#infect()
syntax on
filetype plugin indent on

" ish I love
set number
set showcmd
set cursorline
set showmatch
" set binary noeol
set cc=72

" Powerline
" http://choorucode.com/2013/02/17/how-to-install-and-use-vim-powerline-plugin-for-vim/
set t_Co=256
let g:Powerline_symbols = "fancy"

" Nerdcommenter
" https://github.com/scrooloose/nerdcommenter
filetype plugin on

" syntastic
" https://github.com/scrooloose/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-markdown
" https://github.com/tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" solarized
" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" taaaaabs - soft tabs, two spaces
" http://vim.wikia.com/wiki/Indenting_source_code
" we do this below with indent-guides, yo.
" set expandtab
" set shiftwidth=2
" set softtabstop=2

" vim-indent-guides
" https://github.com/nathanaelkane/vim-indent-guides
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif

" http://stackoverflow.com/questions/2561418/how-to-comment-out-a-block-of-python-code-in-vim
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

" vim-json
let g:vim_json_warnings = 1
let g:vim_json_syntax_conceal = 0

" dat end of line
" http://stackoverflow.com/questions/1050640/vim-disable-automatic-newline-at-end-of-file
set fileformats+=dos

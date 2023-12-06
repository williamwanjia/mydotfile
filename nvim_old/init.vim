
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 

autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2


set foldmethod=indent

" Setting for NERD Commenter --------------------------------------------\
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following
" code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented
" or not 
let g:NERDToggleCheckAllLines = 1

" END of setting for NERD -----------------------------------------------/ 

" Set spell check highlight
:hi SpellBad cterm=underline ctermfg=red

nmap <Leader>ll :set tw=79<cr>
nmap <Leader>li :set tw=999<cr>
nmap <Leader>ls :set tw=72<cr>


" --------------------------------------------------------
" SETTINGS START

set completeopt=longest,menuone

" SETTINGS END
" --------------------------------------------------------

" --------------------------------------------------------
" COC-VIM TAB SETTINGS START

let g:coc_global_extensions = ['coc-jedi']


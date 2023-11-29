set encoding=utf-8

set number             " Column with line numbers
set linespace=1        " Set line-spacing to minimum.
set showmode           " Show current mode.
set ignorecase         " Search case insensitive...
set smartcase          " ... but not when search pattern contains upper case characters
set cursorline         " Highlight current line
set list               " Show listchars as defined in variable listchars
set guicursor=i:block  " Set cursor to block in insert mode
set nowrap             " Disable line wrapping
set splitbelow         " When splitting horizontaly, open new window below the current one
set splitright         " When splitting vertically, open new window right of the current one
set expandtab          " Prefer spaces over tabs
set tabstop=4          " Set tab size to 4 spaces
set shiftwidth=4       " Set indentation size to 4 spaces
set whichwrap+=<,>,[,] " Go to next line when moving cursor with the arrows

" Always show the signcolumn to void shifting the text each time diagnostics
" appear/become resolved (Coc) and allows git-gutter to show changed lines
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Set leader key to be space
nnoremap <SPACE> <Nop>
let mapleader = " "

call plug#begin()

" Rust development environment
Plug 'rust-lang/rust.vim'

" File explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Completion framework
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'JuliaEditorSupport/julia-vim'

" color schemes
Plug 'joshdick/onedark.vim'
Plug 'romgrk/doom-one.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Copilot
Plug 'github/copilot.vim'

" Multi-cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Highlight words under cursor
Plug 'lfv89/vim-interestingwords'

" Highlight changed lines
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-lualine/lualine.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " ?

call plug#end()

syntax on
filetype plugin on
filetype plugin indent on

lua require('nvim_tree')
lua require('catppuccin_config')
lua require('gitsigns_config')
lua require('evil_lualine')
lua require('treesitter_config')

imap <silent><script><expr> <C-J> copilot#Accept("")
let g:copilot_no_tab_map = v:true


" Highlight column
:au BufWinEnter *.rs set colorcolumn=80,100
:au BufWinEnter *.jl set colorcolumn=80,92
:au BufWinEnter *.md set colorcolumn=80,92

"""""""""""""""""""""""" CoC begin
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
vnoremap <leader>f  <Plug>(coc-format-selected)

" Identifier-based code navigation
nmap <silent> gdd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gds :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gdv :call CocAction('jumpDefinition', 'vsplit')<CR>

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
"""""""""""""""""""""""" CoC end

" Visual mode tweaks
" Prefer excluding trailling whispace when going to the end of line
vnoremap $ $h

" Visual multi
let g:VM_leader = '<SPACE><SPACE>'

" Mimic Emacs Editing in Insert Mode Only
" Move to beginning of line
inoremap <C-A> <Home>
" Move cursor left
inoremap <C-B> <Left>
" Move to end of line
inoremap <C-E> <End>
" Move cursor right
inoremap <C-F> <Right>
" Move cursor up: defined in the Coc section
" Move cursor down: defined in the Coc section
" Mova backwards a word
inoremap <M-b> <Esc>bha
" Move forwards a word
inoremap <M-f> <Esc>ea
" Kill from cursor to end of line accounting for when cursor is at first column
inoremap <expr> <silent> <C-k>
      \ strlen(getline('.')) == 0 ? "\<Del>" :
      \ col('.') == 1 ? "\<Esc>Di" : "\<Esc>lDa"
" Paste under cursor
inoremap <C-Y> <Esc>Pa
" Delete character under cursor
inoremap <C-d> <Del>
" Delete forward a word accounting for when cursor is at the last column
inoremap <expr> <silent> <M-d>
      \ strlen(getline('.')) == 0 ? "\<Del>" :
      \ col('.') == 1 ? "\<Esc>vedi" : "\<Esc>lvedi"
" Delete backwards a word accounting for when cursor is at the last column
inoremap <expr> <silent> <M-BS>
      \ strlen(getline('.')) == col('.') - 1 ? "\<Esc>vbda" :
      \ "\<Esc>vbdi"
" Add a new line above current line
inoremap <C-o> <Esc>O
" Sabe buffer
inoremap <C-X><C-S> <Esc>:w<CR>a

" Move up and down on selection list integrated with emacs natural movement
inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Down>" :
      \ coc#refresh()
inoremap <silent><expr> <C-p>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ CheckBackspace() ? "\<Up>" :
      \ coc#refresh()

" Other useful shortcuts
" Replace word under cursor
nnoremap <M-d> viwxi

" =========================== File management & FZF begin ===========================
" Switch between tabs
" nnoremap <f-]> :vertical wincmd f<CR>
" nnoremap <f--> wincmd f<CR>
nnoremap <M-Tab> :bNext<CR>
noremap <M-1> :tabn 1<CR>
noremap <M-2> :tabn 2<CR>
noremap <M-3> :tabn 3<CR>
noremap <M-4> :tabn 4<CR>

" File explorer
nnoremap <M-E> :NvimTreeToggle<CR>

" FZF
" Search for files
nnoremap <C-P> :Files<CR>
" Fuzzy-Search in project
nnoremap <leader>f :Rg<CR>
" Search for pattern in project
nnoremap <leader>F :RG<CR>
nnoremap <M-F> :RG<CR>
" Open list of open buffers
nnoremap <M-b> :Buffers<CR>
" Preview window is hidden by default. You can toggle it with ctrl-_.
" It will show on the right with 50% width
let g:fzf_preview_window = ['hidden,right,50%', 'ctrl-_']

" Use tiebreak=end to prefer matching filenames instead paths
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--tiebreak=end', '--info=inline']}, <bang>0)
" =========================== File management & FZF end ===========================

" Highlight words
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

" Commentary
" ÷ is <M-/> in my machine
noremap ÷ :Commentary<CR>
inoremap ÷ <Esc>:Commentary<CR>a
noremap <leader>c :Commentary<CR>

" Search and replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Rust-specific
let g:rustfmt_autosave = 1
nnoremap <Leader>rr :RustRun<CR>
nnoremap <Leader>rt :RustTest<CR>

" Typescript-specific
autocmd BufNewFile,BufRead *.ts setlocal tabstop=2
autocmd BufNewFile,BufRead *.ts setlocal shiftwidth=2

colorscheme catppuccin

set statusline+=%{get(b:,'gitsigns_status','')}

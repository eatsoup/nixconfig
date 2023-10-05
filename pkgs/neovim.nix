{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim coc-git coc-highlight coc-pyright coc-rls coc-vetur coc-vimtex coc-yaml coc-html coc-json coc-go
      ctrlp
      fzf-vim
      gruvbox
      nerdtree
      rainbow
      vim-nix
      vim-surround
      commentary
      vim-easymotion
    ];
    extraConfig = ''
      colorscheme gruvbox
      set tabstop=4 autoindent shiftwidth=4 expandtab number
      set smartcase ignorecase
      set incsearch
      set backspace=indent,eol,start
      set listchars=tab:▸\ ,trail:·
      set list
      set mouse=
      set relativenumber

      let mapleader="\<space>"

      map <c-i> :tabn<CR>

      "Easy quotes life
      inoremap "" ""<left>
      inoremap "<CR> {<CR>}<Esc>O<Tab>
      inoremap ''' '''<left>
      inoremap () ()<left>
      inoremap (<CR> (<CR>)<Esc>O<Tab>
      inoremap {} {}<left>
      inoremap {<CR> {<CR>}<Esc>O<Tab>
      inoremap [] []<left>
      inoremap [<CR> [<CR>]<Esc>O<Tab>
      inoremap <> <><left>
      inoremap <C-a> <right>
      nmap <Leader>' ysiw'
      nmap <Leader>" ysiw"
      noremap <Leader>/ :Commentary<cr>

      " Coc settings
      inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
      inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
      inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

      " $ in visual mode should jump one less
      vnoremap $ $<left>

      " Format raw json using jq
      function! FormatJson()
          %!jq .
          let &syntax = "json"
      endfunction
      noremap <Leader>fj :call FormatJson()<cr>

      " yank and paste from clipboard
      noremap <Leader>y "+y
      noremap <Leader>p "+p
    '';
  };
}

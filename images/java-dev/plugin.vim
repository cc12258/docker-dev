" Completion backend
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Completion frontend
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

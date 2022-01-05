{ config, pkgs, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;

  preview-file = pkgs.writeShellScriptBin "preview-file" (import ./preview-file.nix pkgs);

  instant-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "instant";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "instant.nvim";
      rev = "c02d72267b12130609b7ad39b76cf7f4a3bc9554";
      sha256 = "sha256-7Pr2Au/oGKp5kMXuLsQY4BK5Wny9L1EBdXtyS5EaZPI=";
    };
  };

  sonokai = pkgs.vimUtils.buildVimPlugin {
    name = "sonokai";
    src = pkgs.fetchFromGitHub {
      owner = "sainnhe";
      repo = "sonokai";
      rev = "51e7ee8b13f9c2e4eae33f8d745eaa1f320b0ae6";
      sha256 = "0svqr6dnpk2p5qhb6j0rllns8f0f4886wxpx69wgazjx84bx728i";
    };
  };
  suda = pkgs.vimUtils.buildVimPlugin {
    name = "suda";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "suda.vim";
      rev = "fbb138f5090c3db4dabeba15326397a09df6b73b";
      sha256 = "ztZ5UPd2y4Mkore/QLfMCwjM0Qy4eWCOw535NzDSfgY=";
    };
  };
  workspace = pkgs.vimUtils.buildVimPlugin {
    name = "vim-workspace";
    src = pkgs.fetchFromGitHub {
      owner = "thaerkh";
      repo = "vim-workspace";
      rev = "faa835406990171bbbeff9254303dad49bad17cb";
      sha256 = "w6CcFcIplwUVcvx54rbTwThBxus1k7yHot2TpdNQ61M=";
    };
  };
  beautify = pkgs.vimUtils.buildVimPlugin {
    name = "vim-beautify";
    src = pkgs.fetchFromGitHub {
      owner = "zeekay";
      repo = "vim-beautify";
      rev = "e0691483927dc5a0c051433602397419f9628623";
      sha256 = "QPTCl6KaGcAjTS5yVDov9yxmv0fDaFoPLMsrtVIG6GQ=";
    };
  };
in
{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  withNodeJs = true;
  withRuby = true;
  withPython3 = true;

  extraPackages = with pkgs; [
    ccls
    gopls
    nodejs
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.svelte-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.vue-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    python39Packages.python-lsp-server
    python3Full
    solargraph
    rnix-lsp
    rust-analyzer
    terraform-ls
    universal-ctags
  ];

  plugins = with pkgs.vimPlugins; [
    nvim-cmp
    cmp-nvim-lsp
    cmp_luasnip
    luasnip

    lsp_extensions-nvim
    nvim-lspconfig

    instant-nvim

    ack-vim
    airline
    editorconfig-vim
    nnn-vim
    suda
    syntastic
    vim-gutentags
    vim-vinegar
    workspace

    sonokai

    fugitive
    vim-gitgutter
    vim-rhubarb
    vimagit

    fzf-vim
    fzfWrapper
    vim-highlightedyank

    beautify
    vim-surround

    vim-bufkill
    vim-sensible

    ansible-vim
    emmet-vim
    rust-vim
    vim-go
    vim-javascript
    vim-json
    vim-markdown
    vim-nix
    vim-ruby
    vim-toml
    vim-vue
    yats-vim
  ];

  extraConfig = builtins.concatStringsSep "\n" [
    ''
      " Persistent undo
      set undofile
      set undodir=${xdg.cacheHome}/nvim/undo

      set backupdir=${xdg.dataHome}/nvim/backup
      set directory=${xdg.dataHome}/nvim/swap/
    ''
    (builtins.readFile ./init.vim)
    (builtins.readFile ./plugins.vim)
    (builtins.readFile ./clipboard.vim)
    (builtins.readFile ./ui.vim)
    (builtins.readFile ./quickfixopenall.vim)
    (builtins.readFile ./lsp.vim)
    ''
      " fzf with file preview
      command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, { 'options': ['--keep-right', '--cycle', '--layout', 'reverse', '--preview', '${preview-file}/bin/preview-file {}'] }, <bang>0)
    ''
  ];
}

{ config, pkgs, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;

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
  ];

  extraPackages = with pkgs; [
    nodejs
    code-minimap
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.vim-language-server
    nodePackages.vue-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    python3Full
    python-language-server
    solargraph
    rust-analyzer
    ctags
    ccls
    rnix-lsp
    terraform-ls
  ];

  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    lsp_extensions-nvim
    completion-nvim

    suda
    ack-vim
    syntastic
    airline
    workspace
    editorconfig-vim
    vim-vinegar
    vim-gutentags
    minimap-vim
    nnn-vim

    sonokai

    fugitive
    vim-gitgutter
    vimagit

    vim-highlightedyank
    fzf-vim
    fzfWrapper

    beautify
    vim-surround

    vim-sensible
    vim-bufkill

    ansible-vim
    emmet-vim
    rust-vim
    vim-go
    vim-vue
    vim-javascript
    vim-json
    vim-markdown
    yats-vim
    vim-ruby
    vim-toml
    vim-nix
  ];
}

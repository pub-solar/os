{ config, pkgs, self, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  dotDir = ".config/zsh";

  history = {
    ignoreDups = true;
    expireDuplicatesFirst = true;
    ignoreSpace = true;
    path = "$HOME/.local/share/zsh/zsh_history";
    save = 10000;
    size = 10000;
  };

  loginExtra = ''
    [ "$(tty)" = "/dev/tty1" ] && exec sway
  '';

  shellAliases = {
    nano = "nvim";
    vi = "nvim";
    vim = "nvim";
    mutt = "neomutt";
    ls = "exa";
    la = "exa --group-directories-first -lag";
    fm = "vifm .";
    vifm = "vifm .";
    wget = "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts";
    irssi = "irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi";
    drone = "DRONE_TOKEN=$(secret-tool lookup drone token) drone";
    no = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
    # fix nixos-option
    nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";
    myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";
  };
  zplug = {
    enable = true;
    plugins = [
      {
        name = "plugins/z";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "romkatv/powerlevel10k";
        tags = [ "as:theme" "depth:1" ];
      }
      { name = "zdharma/fast-syntax-highlighting"; }
      { name = "chisui/zsh-nix-shell"; }
    ];
  };

  initExtra = ''
    bindkey -v
    bindkey -v 'jj' vi-cmd-mode
    bindkey -a 'i' up-line
    bindkey -a 'k' down-line
    bindkey -a 'j' backward-char
    bindkey -a 'h' vi-insert
    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '^ ' autosuggest-accept
    bindkey '^q' push-line-or-edit

    bindkey '^R' fzf-history-widget

    # ArrowUp/Down start searching history with current input
    autoload -U up-line-or-beginning-search
    autoload -U down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search
    bindkey "^P" up-line-or-beginning-search
    bindkey "^N" down-line-or-beginning-search

    # MAKE CTRL+S WORK IN VIM
    stty -ixon
    stty erase '^?'

    precmd () {
      DIR_NAME=$(pwd | sed "s|^$HOME|~|g")
      echo -e "\e]2;$DIR_NAME\e\\"
    }

    # If a command is not found, show me where it is
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  ''
  + builtins.readFile ./base16.zsh
  + builtins.readFile ./p10k.zsh
  +
  ''
    source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    source ${pkgs.fzf}/share/fzf/completion.zsh
    source ${pkgs.git-bug}/share/zsh/site-functions/git-bug
    eval "$(direnv hook zsh)"
  '';
}

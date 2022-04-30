{ lib, config, pkgs, self, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.terminal-life;
in
{
  options.pub-solar.terminal-life = {
    enable = mkEnableOption "Life in black and white";
  };

  config = mkIf cfg.enable {
    programs.command-not-found.enable = false;

    # Needed to get zsh completion for system packages (e.g. systemd).
    environment.pathsToLink = [ "/share/zsh" ];

    environment.shells = with pkgs; [
      zsh
    ];

    environment.systemPackages = with pkgs; [
      screen
    ];

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        ack
        asciinema
        ag
        bat
        exa
        fd
        gh
        glow
        nnn
        powerline
        vifm
        watson
      ];

      programs.neovim = import ./nvim { inherit config; inherit pkgs; };
      programs.fzf = import ./fzf { inherit config; inherit pkgs; };
      programs.zsh = import ./zsh { inherit config; inherit pkgs; inherit self; };
    };
  };
}

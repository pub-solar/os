{ config, pkgs, ... }:
{
  enable = true;
  defaultCommand = "fd --hidden --type f --exclude .git";
  defaultOptions = [
    "--color=bg+:#2d2a2e,bg:#1a181a,spinner:#ef9062,hl:#7accd7"
    "--color=fg:#d3d1d4,header:#7accd7,info:#e5c463,pointer:#ef9062"
    "--color=marker:#ef9062,fg+:#303030,prompt:#e5c463,hl+:#7accd7"
  ];
  enableZshIntegration = true;
}

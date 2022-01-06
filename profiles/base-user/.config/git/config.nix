{ config, pkgs, ... }:
let
  user = config.pub-solar.user;
  xdg = config.home-manager.users."${user.name}".xdg;
in
''[user]
  ${if user.email != null then "email = ${user.email}" else ""}
  ${if user.fullName != null then "name = ${user.fullName}" else ""}
  ${if user.gpgKeyId != null then "signingkey = ${user.gpgKeyId}" else ""}
[core]
  editor = /etc/profiles/per-user/${config.pub-solar.user.name}/bin/nvim
  excludesFile = /home/${config.pub-solar.user.name}/.config/git/global_gitignore
[alias]
  pol = pull
  ack = -c color.grep.linenumber=\"bold yellow\"\n    -c color.grep.filename=\"bold green\"\n    -c color.grep.match=\"reverse yellow\"\n    grep --break --heading --line-number
# define command which will be used when "nvim"is set as a merge tool

[mergetool]
  prompt = false
[merge]
  tool = nvim
[mergetool "nvim"]
  cmd = /etc/profiles/per-user/${config.pub-solar.user.name}/bin/nvim -f -c \"Gdiffsplit!\" \"$MERGED\"

[commit]
  gpgsign = true
[tag]
  gpgsign = true
[init]
  defaultBranch = main
[pull]
  rebase = false''

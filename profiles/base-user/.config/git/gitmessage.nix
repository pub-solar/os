{ config, pkgs, ... }:
let
  user = config.pub-solar.user;
  xdg = config.home-manager.users."${user.name}".xdg;
in
''
# Title: Summary, imperative, start upper case, don't end with a period
# No more than 50 chars. #### 50 chars is here:  #
#


# ^ Remember ending with an extra blank line
# Body: Explain *what* and *why* (not *how*). Include issue number.
# Wrap at 72 chars. ################################## which is here:  #
#


# ^ Remember ending with an extra blank line
# At the end: Include Co-authored-by for all contributors.
#
Co-authored-by: ${user.fullName} <${user.email}>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/main'.
#
# Changes to be committed:
#       new file:   installation.md
#
''

{ config, pkgs, ... }:
let
  user = config.pub-solar.user;
  xdg = config.home-manager.users."${user.name}".xdg;
in
''
# Title: Summary, imperative, start upper case, don't end with a period
# No more than 50 chars. #### 50 chars is here:  #
#

#
# Remember blank line between title and body.
#

#
# Body: Explain *what* and *why* (not *how*). Include issue number.
# Wrap at 72 chars. ################################## which is here:  #
#

#
# At the end: Include Co-authored-by for all contributors.
# Include at least one empty line before it. Format:
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

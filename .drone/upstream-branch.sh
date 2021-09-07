#!/usr/bin/env sh

set -e
set -u

LOCAL="$DRONE_BRANCH"
[ "$LOCAL" = "master" ] && UPSTREAM=origin/devos || UPSTREAM=origin/master

git fetch --all
git checkout "$LOCAL"
git merge "$UPSTREAM"
git push origin "$LOCAL"

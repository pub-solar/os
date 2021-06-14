#!/usr/bin/env sh

set -e
set -u

LOCAL="$DRONE_BRANCH"
[ "$LOCAL" = "core" ] && UPSTREAM=origin/devos || UPSTREAM=origin/core

git fetch --all
git checkout "$LOCAL"
git merge "$UPSTREAM"
git push origin "$LOCAL"

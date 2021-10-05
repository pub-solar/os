#!/usr/bin/env sh

set -e
set -u

LOCAL="$DRONE_BRANCH"
[ "$LOCAL" = "main" ] && UPSTREAM=origin/devos || UPSTREAM=origin/main

git fetch --all
git checkout "$LOCAL"
git merge "$UPSTREAM"
git push origin "$LOCAL"

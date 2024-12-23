#!/usr/bin/env bash

while ! ping -c 1 archlinux.org; do
	true
done

# Navigate to the local Git repository
REPO_DIR="$(fd -td sneederland -a $HOME)"
cd "$REPO_DIR" || exit

# Fetch the latest changes from the remote repository
git fetch origin

# Check if the local branch is behind the remote branch
LOCAL="$(git rev-parse @)"
REMOTE="$(git rev-parse @{u})"

[ "$LOCAL" != "$REMOTE" ] && notify-send "Update available for SneederLand" "Run git pull in $REPO_DIR and run installer.sh" -u critical -i edit-download

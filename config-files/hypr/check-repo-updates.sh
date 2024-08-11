#!/bin/bash

# Navigate to the local Git repository
REPO_DIR="$(fd -td sneederland -a)"
cd "$REPO_DIR" || exit

# Fetch the latest changes from the remote repository
git fetch origin

# Check if the local branch is behind the remote branch
LOCAL="$(git rev-parse @)"
REMOTE="$(git rev-parse @{u})"

[ "$LOCAL" != "$REMOTE" ] && git pull

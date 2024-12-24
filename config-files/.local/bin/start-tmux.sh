#!/usr/bin/env bash

systemctl --user enable --now tmux.service
while ! systemctl --user status tmux; do
	systemctl --user enable --now tmux.service
done

#!/usr/bin/env bash

systemctl --user enable --now gammastep.service
while ! systemctl --user status gammastep; do
	systemctl --user enable --now gammastep.service
done

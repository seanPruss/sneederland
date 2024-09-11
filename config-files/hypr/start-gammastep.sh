#!/bin/bash
systemctl --user enable --now geoclue-agent.service
systemctl --user enable --now gammastep.service
while true; do
	if ! systemctl --user status gammastep; then
		systemctl --user enable --now geoclue-agent.service
		systemctl --user enable --now gammastep.service
		sleep 60
	fi
done

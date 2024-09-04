#!/bin/bash
while true; do
	if [[ -z "$(pgrep gammastep)" ]]; then
		systemctl --user enable --now geoclue-agent.service
		systemctl --user enable --now gammastep.service
	fi
	sleep 60
done

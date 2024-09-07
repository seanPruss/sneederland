#!/bin/bash
while true; do
	systemctl --user enable --now geoclue-agent.service
	systemctl --user enable --now gammastep.service
	sleep 60
done

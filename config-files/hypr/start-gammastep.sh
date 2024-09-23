#!/bin/bash
systemctl --user enable --now geoclue-agent.service
systemctl --user enable --now gammastep.service
while ! systemctl --user status gammastep; do
	systemctl --user enable --now geoclue-agent.service
	systemctl --user enable --now gammastep.service
	sleep 10
done

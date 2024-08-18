#!/bin/bash
systemctl --user enable --now geoclue-agent.service
sleep 1
systemctl --user enable --now gammastep.service

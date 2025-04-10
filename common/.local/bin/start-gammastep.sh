#!/usr/bin/env bash

while ! ping -c 1 archlinux.org; do
	true
done
latitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 1)
longitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 2)
while true; do
	pgrep gammastep || gammastep -t 6500:1500 -l "$latitude":"$longitude" &
	sleep 30
done

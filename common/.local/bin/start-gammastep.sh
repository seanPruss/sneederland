#!/usr/bin/env bash

while ! ping -c 1 archlinux.org; do
	true
done
gammastep -t 6500:1500 -l $(curl ipinfo.io/loc | sed 's/,/:/g')

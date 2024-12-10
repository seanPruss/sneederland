#!/usr/bin/env bash
latitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 1)
longitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 2)
gammastep -t 6500:1200 -l $latitude:$longitude

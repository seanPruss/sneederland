#!/usr/bin/env bash

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
echo "$artist - $title"

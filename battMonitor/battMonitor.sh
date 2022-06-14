#!/usr/bin/env bash

: '
Source; https://unix.stackexchange.com/a/227222 

autostart noGoFF battery alert script when pc boots up
'

if [[ -n "$(pgrep -f noGoFF.sh)" ]]; then
  exit
else
  noGoFF.sh&
fi

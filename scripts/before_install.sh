#!/bin/bash
DIR="/var/www/lirw-app"
if [ -d "$DIR" ]; then
  rm -rf "$DIR"
fi
mkdir -p "$DIR"
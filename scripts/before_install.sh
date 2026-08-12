#!/bin/bash
set -e

DIR="/var/www/lirw-app"

echo "Cleaning up destination directory..."
rm -rf "$DIR"
mkdir -p "$DIR"
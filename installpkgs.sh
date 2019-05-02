#! /bin/sh

sudo pacman -S --needed - < pkglist.txt || true
aurget -S "$(< foreignpkglist.txt)" || true


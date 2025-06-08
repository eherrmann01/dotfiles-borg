#!/usr/bin/sh

for img in *.jpg; do
   magick "$img" -quality 70 "$img"
done

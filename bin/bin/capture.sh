#!/bin/bash
slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo $slop)
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -c:v libx264 -preset ultrafast -qp 0 ~/myfile.mp4

#!/bin/bash

XRANDR=xrandr

LAST=
while read -r OUTPUT MODE;
do
    if [ -z $LAST ];
    then
	$XRANDR --output $OUTPUT --mode $MODE
    else
	$XRANDR --output $OUTPUT --mode $MODE --right-of $LAST
    fi
    LAST=$OUTPUT
done < <(xrandr --query | awk '$2=="connected" {OUTPUT=$1; getline; MODE=$1; print OUTPUT,MODE}')

$XRANDR --output $LAST --primary

#!/bin/bash
default_sink=$(pactl info | sed -n 's/Default Sink: \(.*\)/\1/p')

sinks=($(pactl list short sinks | cut -f 2))
echo ${sinks[@]}

## Find next sink
i=1
for sink in ${sinks[@]};
do
    if [ "$sink" == "$default_sink" ];
    then
	break
    fi
    i=$((i+1))
done
if [ $i -eq ${#sinks[@]} ];
then
    i=0
fi
new_sink=${sinks[i]}

## Set new_sink as default
pactl set-default-sink $new_sink

## Move all sink-inputs to new_sink
inputs=($(pactl list short sink-inputs | cut -f 1))
for input in ${inputs[@]};
do
    pactl move-sink-input $input $new_sink
done


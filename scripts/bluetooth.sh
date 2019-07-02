#!/bin/bash

bluetoothctl <<EOF
power on
connect "F8:DF:15:AC:CE:FA"
exit
EOF

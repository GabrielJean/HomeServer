#!/bin/bash

State=$(sudo pwrstat -status | grep State | sed 's/State........................ //' | xargs)

if [ $State == "Normal" ]
then
    curl -fsS -m 10 --retry 5 -o /dev/null http://10.10.0.8:9500/ping/3571ae4b-2d0f-4484-9e6e-d53fdb8cb4b6
else
    curl -fsS -m 10 --retry 5 -o /dev/null http://10.10.0.8:9500/ping/3571ae4b-2d0f-4484-9e6e-d53fdb8cb4b6/fail
fi
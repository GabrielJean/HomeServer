#!/bin/bash

curl -fsS -m 10 --retry 5 --data-raw "$SMARTD_MESSAGE" -o /dev/null http://10.10.0.8:9500/ping/3bf83aec-e0a9-44a6-bd05-0d8004cabbab/fail 

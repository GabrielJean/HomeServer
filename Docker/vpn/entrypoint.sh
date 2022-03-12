#!/bin/sh

command='tailscale up --reset'

#advertise-routes
if [[ -z "${ADVERTISE_ROUTES}" ]]; then
  echo "No Route set..."
else
  command="${command} --advertise-routes ${ADVERTISE_ROUTES}"
fi

if [[ -z "${AUTH_KEY}" ]]; then
  echo "No Auth Key Specified"
else
  command="${command} --authkey ${AUTH_KEY}"
fi


sleep 5 && eval $command 2>&1 &
tailscaled
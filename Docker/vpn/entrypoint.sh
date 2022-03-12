tailscaled &
sleep 2 && tailscale up --reset --auth-key ${AUTH_KEY} --advertise-routes ${ADVERTISE_ROUTES}

wait

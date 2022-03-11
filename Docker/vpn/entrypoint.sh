echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

tailscaled &
tailscale up --auth-key=tskey-kGzQnr2CNTRL-FeGnxeYLNabBbwWHaH6ZAR --advertise-routes "10.10.0.0/24"

wait

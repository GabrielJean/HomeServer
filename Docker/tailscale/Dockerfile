FROM tailscale/tailscale:stable@sha256:64a6aa7820e0c46f7a99ee5ed7ea79b252649ac1e8934b5436123265418e9bc3


RUN mkdir /tailscale
WORKDIR /tailscale

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

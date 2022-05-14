FROM tailscale/tailscale:stable@sha256:fade10ce4b55873727e8567d54725c56101bb94a64236868a4e0a8019420ec43


RUN mkdir /tailscale
WORKDIR /tailscale

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

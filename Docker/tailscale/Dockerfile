FROM tailscale/tailscale:stable@sha256:053305b670261c5f0dfd1447a56afc9fa1a33650552bb13669b429245dd1da06


RUN mkdir /tailscale
WORKDIR /tailscale

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

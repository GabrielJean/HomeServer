FROM tailscale/tailscale:stable@sha256:ac0c192f6cba52877e4d9c2fe8943f16c0ab44927605a21416852590e3ccb71e


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

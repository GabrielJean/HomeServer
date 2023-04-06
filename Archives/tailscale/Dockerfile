FROM tailscale/tailscale:stable@sha256:b97d51b7131dbdf1ef9994b6f447adacb2c1301d4af246c742a467fadac8f438


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

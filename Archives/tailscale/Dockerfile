FROM tailscale/tailscale:stable@sha256:8abcbcfe179c454ab4c3b583626c4e5b2edcb7c0851fe09ba3313d4ca02aacdc


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

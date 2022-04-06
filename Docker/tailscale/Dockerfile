FROM tailscale/tailscale


RUN mkdir /tailscale
WORKDIR /tailscale

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]
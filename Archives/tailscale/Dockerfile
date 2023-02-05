FROM tailscale/tailscale:stable@sha256:4aa8d3ab09bb42b2a706d4d780ceedd054498e4d41dba2f0197087ad0d060cd0


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

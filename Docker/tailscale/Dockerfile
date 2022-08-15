FROM tailscale/tailscale:stable@sha256:2eab3213497432b48d0f02add629b0c2ebb3dc207069353a9ede1deed50961e9


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

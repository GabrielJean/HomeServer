FROM tailscale/tailscale:stable@sha256:60e2afbbe56f698374ede2dc910e48595edc2f98053b5c96123fb9d78e7e424f


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

FROM tailscale/tailscale:stable@sha256:b915f3d99b5b54ff93f33bb79425ff81408d2d9efef18e47ab7a3a4170654eaa


RUN mkdir /tailscale_data
WORKDIR /tailscale_data

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "entrypoint.sh"]

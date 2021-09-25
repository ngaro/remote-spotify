FROM garo/easy-xpra:ubuntu-small
MAINTAINER Nikolas Garofil "nikolas@garofil.be"

#Install spotify, everything is on 1 layer to shrink image size (e.g. cleaning the apt cache on a new layer is pretty useless because the layer before still contains this data)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install curl gpg && curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | apt-key add - && \
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list && apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends spotify-client && \
apt-get -y purge gpg curl && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Run spotify in xpra
CMD ["run_in_xpra", "spotify"]

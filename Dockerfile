FROM ubuntu:18.04
MAINTAINER Nikolas Garofil "nikolas@garofil.be"

#install spotify
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install gpg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 && echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install spotify-client
#install xpra
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install xpra
#clean up
RUN apt-get -y purge gpg && apt-get -y --purge autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#make xpra available on port 10000 on the container
EXPOSE 10000
#by default start a xpra server listening on port 10000 that exits when spotify ends
CMD ["/usr/bin/xpra", "start", ":100", "--start-child=spotify", "--bind-tcp=0.0.0.0:10000", "--no-daemon", "--exit-with-children"]

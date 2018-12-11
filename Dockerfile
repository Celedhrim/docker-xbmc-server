# docker-kodi-server
#
# Create your own Build:
# 	$ docker build --rm=true -t $(whoami)/kodi-server .
#
# Run your build:
#	  $ docker run -d --restart="always" --net=host -v /directory/with/kodidata:/usr/share/kodi/portable_data $(whoami)/kodi-server
#
# Greatly inspire by the work of wernerb,
# See https://github.com/wernerb/docker-xbmc-server

FROM ubuntu:18.04
maintainer celedhrim "celed+git@ielf.org"

# Set Terminal to non interactive
ENV DEBIAN_FRONTEND noninteractive

ADD src/kodi-run-wrapper.sh /bin/kodi-run-wrapper.sh

RUN apt-get update && \
    apt-get install -y xpra software-properties-common && \
    add-apt-repository -y ppa:team-xbmc/unstable && \
    apt-get install -y kodi=2:18.0+git20181203.1750-rc2-0bionic && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /usr/share/man /usr/share/doc && \
    chmod +x /bin/kodi-run-wrapper.sh



EXPOSE 9777/udp 8089/tcp
ENTRYPOINT ["/bin/kodi-run-wrapper.sh"]

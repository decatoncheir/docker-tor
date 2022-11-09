FROM ubuntu:jammy

RUN apt-get update -y && apt-get install -y wget gpg

# Install tor
COPY tor.list /etc/apt/sources.list.d/tor.list

RUN wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null
RUN apt-get update -y \
   && apt-get install -y tor deb.torproject.org-keyring

RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc

CMD /usr/sbin/tor
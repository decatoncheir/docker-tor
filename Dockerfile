# syntax=docker/dockerfile:1.4

FROM ubuntu:jammy

RUN <<EOT
apt-get update -y
apt-get upgrade -y 
apt-get install -y \
   wget \
   gpg
EOT

# Install tor
COPY <<EOT /etc/apt/sources.list.d/tor.list 
deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
EOT

RUN <<EOT
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null
apt-get update -y
apt-get install -y \
   tor \
   deb.torproject.org-keyring
echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc
EOT

CMD /usr/sbin/tor
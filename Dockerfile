FROM ubuntu:latest
LABEL maintainer="Akash Kakkar <akash.galaxy07@gmail.com>"

ENV SQUID_VERSION=4.10 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
SQUID_AUTH_FILE=/etc/squid/passwd \
    SQUID_USER=proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid=${SQUID_VERSION}* \
 && rm -rf /var/lib/apt/lists/*


COPY squid.conf /etc/squid/squid.conf
COPY passwd /etc/squid/passwd

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 51973/tcp
#EXPOSE 3128/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

#
# Build: docker build -t apt-cacher .
# Run: docker run -d -p 3142:3142 --name apt-cacher-run apt-cacher
#
# and then you can run containers with:
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
#
# Here, `dockerhost` is the IP address or FQDN of a host running the Docker daemon
# which acts as an APT proxy server.
FROM  debian:stable

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ENV APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng

VOLUME  /var/cache/apt-cacher-ng

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    libmime-base64-perl \
    locales \
    sed \
    curl \
    apt-cacher-ng

RUN echo "locales locales/default_environment_locale select fr_FR.UTF-8" | debconf-set-selections \
    && echo "locales locales/locales_to_be_generated multiselect 'fr_FR.UTF-8 UTF-8'" | debconf-set-selections \
    && echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && locale-gen --purge en_US.UTF-8  \
    && rm -rf /var/lib/apt/lists/* ;

EXPOSE  3142

CMD  chmod 777 /var/cache/apt-cacher-ng
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN  chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

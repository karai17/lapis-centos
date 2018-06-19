FROM centos:latest

LABEL maintainer="Landon Manning <lmanning17@gmail.com>"

# Software versions
ENV LUAROCKS_VERSION="2.4.4"
ENV RESTY_VERSION="1.13.6.2"
ENV SERVER_MODE="production"
ENV PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

# Prepare volumes
VOLUME /var/data
VOLUME /var/www

# Necessary files
ADD OpenResty.repo /etc/yum.repos.d/OpenResty.repo
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install from Yum
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install \
      gcc \
      git \
      luajit \
      luajit-devel \
      make \
      openresty-${RESTY_VERSION} \
      openresty-opm-${RESTY_VERSION} \
      openresty-resty-${RESTY_VERSION} \
      openssl \
      openssl-devel \
      unzip; \
    yum clean all

# Install LuaRocks
RUN cd /tmp  \
 && curl -fSL http://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz -o luarocks-${LUAROCKS_VERSION}.tar.gz \
 && tar xzf luarocks-${LUAROCKS_VERSION}.tar.gz \
 && cd luarocks-${LUAROCKS_VERSION} \
 && ./configure \
      --prefix=/usr \
      --lua-suffix=jit \
      --with-lua-include=/usr/include/luajit-2.0 \
 && make build \
 && make install \
 && cd / \
 && rm /tmp/* -r

# Install from LuaRocks
RUN luarocks install luasec
RUN luarocks install bcrypt
RUN luarocks install busted
RUN luarocks install i18n
RUN luarocks install lapis
RUN luarocks install luacov
RUN luarocks install mailgun
RUN luarocks install markdown

# Link OpenResty logs to /dev
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log
RUN ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Standard web port (use a reverse proxy for SSL)
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

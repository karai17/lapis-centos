FROM centos:latest

LABEL maintainer="Landon Manning <lmanning17@gmail.com>"

# Environment
ARG LUAROCKS_VERSION="3.0.4"
ENV SERVER_MODE="production"
ENV PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

# Prepare volumes
VOLUME /var/data
VOLUME /var/www

# Entry
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install from Yum
RUN yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo; yum clean all
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install \
      gcc \
      git \
      make \
      openresty \
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
		--with-lua=/usr/local/openresty/luajit \
      --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
 && make build \
 && make install \
 && cd /

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

# Cleanup /tmp
RUN rm /tmp/* -r

# Cleanup yum
RUN yum -y remove \
      gcc \
      git \
      make \
      openssl \
      openssl-devel \
		perl \
      unzip; \
    yum clean all

# Standard web port (use a reverse proxy for SSL)
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

FROM centos:latest

MAINTAINER Landon Manning <lmanning17@gmail.com>

ARG LUAROCKS_VERSION="2.4.1"
ARG RPM_VERSION="1.11.2.4"

COPY OpenResty.repo /etc/yum.repos.d/OpenResty.repo

RUN yum install -y epel-release && \
	yum install -y \
		gcc \
		git \
		luajit \
		luajit-devel \
		make \
		nano \
		openresty-${RPM_VERSION} \
		openresty-opm-${RPM_VERSION} \
		openresty-resty-${RPM_VERSION} \
		openssl \
		openssl-devel \
		unzip && \
	yum clean all && \
	cd /tmp  && \
	curl -fSL http://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz -o luarocks-${LUAROCKS_VERSION}.tar.gz && \
	tar xzf luarocks-${LUAROCKS_VERSION}.tar.gz && \
	cd luarocks-${LUAROCKS_VERSION} && \
	./configure \
		--prefix=/usr \
		--lua-suffix=jit \
		--with-lua-include=/usr/include/luajit-2.0 && \
	make build && \
	make install && \
	cd / && \
	rm /tmp/* -r && \
	ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log && \
	ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log && \
	luarocks install lapis

ENV PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

# Lapis CentOS

This is a Docker image that you can use as a base to quickly set up and deploy
web applications that use the Lapis framework.

# Usage

## Environment Variables

* **LUAROCKS_VERSION** - Default is `3.0.4`
* **SERVER_MODE** - Default is `production`

## Example Script

```sh
docker run \
-dti \
-v "/home/karai/lapis-test/data:/var/data" \
-v "/home/karai/lapis-test/www:/var/www" \
-e SERVER_MODE="development" \
-p 8080:80 \
--name lapis-test \
karai17/lapis-centos:latest
```

## Example Application

Please visit the GitHub repository to download an example application that is
pre-configured for this image. The application is in the `www` directory. Copy
the contents of this directory into your `www` volume as listed in the above
example script.

# Notes

Due to an issue with lua-cjson not compiling on the latest beta of LuaJIT 2.1,
this Docker image installs LuaJIT 2.0 from the CentOS EPEL repo and uses that
for LuaRocks. OpenResty still uses its own local LuaJIT 2.1, so let's hope the
binaries built on LuaJIT 2.0 are compatible!

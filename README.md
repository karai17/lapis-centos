# Lapis CentOS

This is a docker image that you can use as a base to quickly set up and deploy
web applications that use the Lapis framework.

# Included

This image is a CentOS environment using the OpenResty web server bundle. Also
included is LuaJIT, LuaRocks, Lapis, Nano, and OpenSSL.

# Notes

Due to an issue with lua-cjson not compiling on the latest beta of LuaJIT 2.1,
this Docker image installs LuaJIT 2.0.4 from the CentOS EPEL repo and uses that
for LuaRocks. OpenResty still uses its own local LuaJIT 2.1, so let's hope the
binaries built on LuaJIT 2.0.4 are compatible!

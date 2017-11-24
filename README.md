# Lapis CentOS

This is a docker image that you can use as a base to quickly set up and deploy
web applications that use the Lapis framework.

# Included

This image includes the following software:

* bcrypt (Lua)
* GCC
* Git
* i18n (Lua)
* Lapis (Lua)
* LuaJIT
* LuaRocks
* LuaSec (Lua)
* Make
* Mailgun (Lua)
* Markdown (Lua)
* OpenResty
* OpenSSL
* Unzip

# Notes

Due to an issue with lua-cjson not compiling on the latest beta of LuaJIT 2.1,
this Docker image installs LuaJIT 2.0 from the CentOS EPEL repo and uses that
for LuaRocks. OpenResty still uses its own local LuaJIT 2.1, so let's hope the
binaries built on LuaJIT 2.0 are compatible!

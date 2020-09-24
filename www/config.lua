local config = require "lapis.config"

-- Maximum file size
local body_size = "1m"

-- Path to your local project files
local lua_path  = "./src/?.lua;./src/?/init.lua;./libs/?.lua;./libs/?/init.lua"
local lua_cpath = ""

config("development", {
	port      = 80,
	body_size = body_size,
	lua_path  = lua_path,
	lua_cpath = lua_cpath
})

config("production", {
	code_cache = "on",
	port       = 80,
	body_size  = body_size,
	lua_path   = lua_path,
	lua_cpath  = lua_cpath
})

config("test", {
	port      = 80,
	body_size = body_size,
	lua_path  = lua_path,
	lua_cpath = lua_cpath
})

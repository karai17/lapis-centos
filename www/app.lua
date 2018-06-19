local lapis = require "lapis"
local app   = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"
app:match("/", require "controllers.index")

return app

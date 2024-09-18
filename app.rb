require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  @data = HTTP.get("https://api.exchangerate.host/list?access_key=98b3818c779196980fc28a692dbb5f64")

  @dstring = @data.to_s

  @dparsed = JSON.parse(@dstring)

  @dkeys = @dparsed.fetch("currencies")
  erb(:homepage)
end

get("/:country") do

  @code = params.fetch("country")

  erb(:convert)

end

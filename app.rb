require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  access_key = ENV.fetch("TE").strip
  @data = HTTP.get("https://api.exchangerate.host/list?access_key=#{access_key}")

  @dstring = @data.to_s

  @dparsed = JSON.parse(@dstring)

  @dkeys = @dparsed.fetch("currencies")
  erb(:homepage)
end

get("/:country") do

  @data = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("TE")}")

  @code = params.fetch("country")

  @dstring = @data.to_s

  @dparsed = JSON.parse(@dstring)

  @dkeys = @dparsed.fetch("currencies")

  erb(:convert)

end

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

  access_key = ENV.fetch("TE").strip
  @data = HTTP.get("https://api.exchangerate.host/list?access_key=#{access_key}")

  @code = params.fetch("country")

  @dstring = @data.to_s

  @dparsed = JSON.parse(@dstring)

  @dkeys = @dparsed.fetch("currencies")

  erb(:convert)

end

get("/:from/:to") do 
  @from = params.fetch("from")
  @to = params.fetch("to")

  @mdata = HTTP.get("https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{access_key}")

  @mdstring = @mdata.to_s
  
  @mdparsed = JSON.parse(@mdstring)

  @mdvalue = @mdparsed["result"]

  erb(:conversion)
end

require "sinatra"
require "sinatra/reloader"
require "http"
require "json"




get("/") do
  

    

  secret_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "http://api.exchangerate.host/list?access_key=#{secret_key}"

  raw_response = HTTP.get(api_url)
  
  raw_data_string = raw_response.to_s
  
  parsed_response = JSON.parse(raw_data_string)

  #curr = parsed_response.fetch("currencies").to_s

  #@currencies_list = params.fetch("curr")



  erb(:homepage)


end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")
  
  secret_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "http://api.exchangerate.host/list?access_key=#{secret_key}"

  raw_response = HTTP.get(api_url)
  
  raw_data_string = raw_response.to_s
  
  parsed_response = JSON.parse(raw_data_string)


  
  @ps_key = parsed_response.fetch("currencies")

  

  erb(:from_c)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  secret_key = ENV.fetch("EXCHANGE_RATE_KEY")
  

  api_url = "http://api.exchangerate.host/convert?access_key=#{secret_key}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  # some more code to parse the URL and render a view template
  raw_response = HTTP.get(api_url)
  
  raw_data_string = raw_response.to_s
  
  parsed_response = JSON.parse(raw_data_string)

  
  
  # some more code to parse the URL and render a view template
  #@user_choice = parsed_response.fetch("query").to_s
 
  @total = parsed_response.fetch("result")

 

  erb(:results)
end

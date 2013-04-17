# sinatra.rb
require "sinatra"
require "net/http"
require "uri"
require "rubygems"
require "json"
require "haml"

load "discovery_config.rb"

get "/" do

  page = File.read("public/index.html")
  
  haml page
  
end

get "/discovery/:discovery_id" do

  page = File.read("public/discovery.html")
  page.sub! "@dscv_id", params[:discovery_id].to_s
  
  haml page
  
end

get "/ajax/discovery/:discovery_id" do

  begin
    json_content = Net::HTTP.get(URI.parse("#{POST_URL}#{params[:discovery_id]}?return-result-since=any_string"))
    json_parsed = JSON.parse(json_content)
    
    json_post = {
      "status" => 0,
      "Name" => json_parsed["name"],
      "State" => json_parsed["state"], 
      "Complete" => json_parsed["percent-complete"],
      "Time" => json_parsed["elapsed-time"],
      "result" => json_parsed["results"]}.to_json
  rescue Errno::ETIMEDOUT
    json_post = {"status" => -1, "message" => "Can't connect to Discovery Server"}.to_json
  rescue NoMethodError, JSON::ParserError
    json_post = {"status" => -1, "message" => "Can't get data from Discovery Server"}.to_json
  end

=begin
  json_post = '{
    "status": 0,
    "Name": "discovery-name",
    "State": "RUNNING",
    "Complete": 70,
    "Time": 7386
  }'
=end
  
  sleep(1)
  json_post.to_s
  
end

get "/ajax/all/" do

  begin
    json_content = Net::HTTP.get(URI.parse(POST_URL))
    json_parsed = JSON.parse(json_content)
    
    json_temp = Array.new
    json_parsed.each do |n|
      json_temp << {
	"Id" => n["discovery-id"],
        "Name" => n["name"],
        "State" => n["state"], 
        "Complete" => n["percent-complete"],
        "Time" => n["elapsed-time"]}
    end
    
    if json_temp.length == 0
      json_post = {"status" => -1, "message" => "Can't get data from Discovery Server"}.to_json
    else
      json_post = {"status" => 0, "discoveries" => json_temp}.to_json
    end
      
  rescue Errno::ETIMEDOUT
    json_post = {"status" => -1, "message" => "Can't connect to Discovery Server"}.to_json
  rescue NoMethodError, JSON::ParserError
    json_post = {"status" => -1, "message" => "Can't get data from Discovery Server"}.to_json
  end

  
=begin
  json_post = '{"status": 0, "discoveries": [{
    "Id": "09aeb857-16d1-4b0e-bc86-8302cb1c4c94",
    "Name": "discovery-name",
    "State": "RUNNING",
    "Complete": 70,
    "Time": 7386
  }, {
    "Id": "09aeb857-16d1-4b0e-bc86-8302cb1c4c94",
    "Name": "discovery-name",
    "State": "RUNNING",
    "Complete": 70,
    "Time": 7386
  }]}'
=end  
  
  sleep(1)
  json_post.to_s
  
end
require "rubygems"
require "sinatra"
require "net/http"
require "uri"
require "json"
require "haml"

load "config.rb"

get "/" do
	page = File.read("public/index.html")  
end


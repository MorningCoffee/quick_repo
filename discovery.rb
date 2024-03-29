require 'logger'
require 'csv'
require 'rubygems'
require 'json'
require 'uri'
require 'net/http'
require 'launchy'

load 'discovery_config.rb'

ERROR_WRONG_NUMBER_OF_ARGUMENTS = 1
ERROR_WRONG_ARGUMENT_NAME_FORMAT = 2
ERROR_WRONG_ARGUMENT_PATHNAME = 3
ERROR_POST_REJECTED = 4
ERROR_WRONG_JSON_STRING_FORMAT = 5

logger = Logger.new(STDOUT)
logger.level = Logger::WARN


logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
end

if ARGV.length != 2
	puts "error: wrong number of arguments"
	exit ERROR_WRONG_NUMBER_OF_ARGUMENTS 
end
 
name_arg = ARGV[0]
FILE_PATH = ARGV[1]
csv_url_index = 4

def check_name?(name)
	if name != "--name="
		puts "error: wrong argument --name format" 
		exit ERROR_WRONG_ARGUMENT_NAME_FORMAT
	end
end

check_name?(name_arg[0..6])

def check_name_empty?(name)
	if name == nil
		puts "error: wrong argument --name format empty"
		exit ERROR_WRONG_ARGUMENT_NAME_FORMAT
	end
end

check_name_empty?(name_arg[7])

if !File.exist?(FILE_PATH)
	puts "error: wrong argument pathname"
	exit ERROR_WRONG_ARGUMENT_PATHNAME
end

URL_arr_unique=Array.new
URL_arr=Array.new
URL_arr2=Array.new
check_arr=false
check_first=true
begin
	CSV.foreach(FILE_PATH) do |csv_line|
    	if check_first==false
  			if csv_line[csv_url_index]!=nil then
  				URL_arr<<csv_line[csv_url_index]
  			end
  		end
  		check_first=false
	end
rescue => err
	logger.error(err)
	check_arr=true
	check_first=true
    CSV.foreach(FILE_PATH, "r:ISO-8859-15:UTF-8") do |csv_line|
        if check_first==false
  			if csv_line[csv_url_index]!=nil then
  				URL_arr2<<csv_line[csv_url_index]
  			end
  		end
    	check_first=false
	end
end

if check_arr==false then
	json_string = {
		"name"=>name_arg, 
  		"input-urls"=>URL_arr
	}.to_json	
else
	json_string = {
		"name"=>name_arg, 
  		"input-urls"=>URL_arr2
	}.to_json	
end

def valid_json?(json_)  
  JSON.parse(json_)  
  return true  
rescue => err
  logger.error(err)	
  return false  
end 

if valid_json?(json_string) == false
	puts "error: wrong json string format" 
	exit ERROR_WRONG_JSON_STRING_FORMAT
end

begin
	uri = URI(POST_URL) #we don't handle URI::InvalidURIError
	res = Net::HTTP.post_form(uri, 'entity' => json_string)
	json_response = JSON.parse("#{res.body}").to_json
	hash_json = JSON.parse(json_response)
	discovery_id = hash_json['discovery-id']
rescue => err
	logger.error(err)
	exit ERROR_POST_REJECTED
end

Launchy::Browser.run(OPEN_URL + discovery_id)

logger.close

exit 0
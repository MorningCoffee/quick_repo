require "csv"

load "discovery_config.rb"

puts "Name:"
NAME = gets.chomp

puts "File path:"
#FILE_PATH = "csv_test.csv"
FILE_PATH = gets.chomp

puts "Count per file:"
COUNT = gets.chomp.to_i

csv_url_index = 4


URL_arr=Array.new

CSV.foreach(FILE_PATH, "r:ISO-8859-15:UTF-8") do |csv_line|
  if csv_line[csv_url_index] != nil then
    URL_arr << csv_line[csv_url_index]
  end
end

URL_arr.delete_at(0);


#index = URL_arr.size / COUNT
master_arr = URL_arr.each_slice(COUNT).to_a

master_arr.each_with_index do |mn, mindex|
  File.open("post#{mindex}.sh", "w+") { 
    |f| f.write("#!/bin/bash

curl -d entity='{ \"name\": \"#{NAME}\", \"input-urls\": [")

    mn.each_with_index do |n, index|
      if index == mn.size - 1
	f.write("\"#{n}\"")
      else
	f.write("\"#{n}\", ")
      end
    end

    f.write("] }' -i #{POST_URL}")
  }
end
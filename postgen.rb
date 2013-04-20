require "csv"
require "optparse"

load "discovery_config.rb"


options = {}

optparse = OptionParser.new do |opts|
  opts.on("--name NAME", "Job name") do |f|
    options[:name] = f
  end
  
  options[:random] = 100
  opts.on("-r [RANDOM]", "Random urls") do |f|
    options[:random] = f || 100
  end
  
  opts.on("--path PATH", "File path") do |f|
    options[:path] = f
  end
  
  options[:count] = 100
  opts.on("-c [COUNT]", "Count per file") do |f|
    options[:count] = f || 100
    options[:random] = 0
  end
  
  options[:prefix] = "post"
  opts.on("--prefix [PREFIX]", "File's name prefix") do |f|
    options[:prefix] = f || "post"
  end
end

optparse.parse!


NAME = options[:name]
FILE_PATH = options[:path]
COUNT = options[:count].to_i
PREFIX = options[:prefix]
RANDOM = options[:random].to_i


csv_url_index = 4


URL_arr = Array.new

CSV.foreach(FILE_PATH, "r:ISO-8859-15:UTF-8") do |csv_line|
  if csv_line[csv_url_index] != nil then
    URL_arr << csv_line[csv_url_index]
  end
end

URL_arr.delete_at(0);

master_arr = Array.new
if RANDOM == 0 then
  master_arr = URL_arr.each_slice(COUNT).to_a
else
  rnd = URL_arr.shuffle
  if RANDOM > URL_arr.size then
    RANDOM = URL_arr.size
  end
  
  master_arr[0] = Array.new
  for i in 0..RANDOM - 1
    master_arr[0] << rnd.pop
  end
end


master_arr.each_with_index do |mn, mindex|
  File.open("#{PREFIX}_#{mindex}.sh", "w+") { 
    |f| f.write("#!/bin/bash

curl -d entity='{ \"name\": \"#{NAME}_#{mindex}\", \"input-urls\": [")

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
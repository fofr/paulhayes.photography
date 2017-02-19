#!/usr/bin/ruby
# Dependency: brew install ExifTool
# http://www.sno.phy.queensu.ca/~phil/exiftool/
# https://github.com/janfri/mini_exiftool

# 500px limit: 30 keywords
# Stock limit: 50 keywords
gem 'mini_exiftool', '2.8.0'
gem 'exifr', '1.2.3.1'
require 'optparse'
require 'mini_exiftool'
require 'exifr'
require "./#{File.dirname(__FILE__)}/keyword_map.rb"

keyword_map = KeywordMap.new
options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: keywords.rb #{$0} [options]"
  opts.on("-t", "--types [TYPES]", Array, "Types of keyword to include") do |types|
    types.each do |type|
      unless keyword_map.respond_to?(type)
        puts "Invalid type provided: #{type}"
        exit
      end
    end
    options[:types] = types
  end

  opts.on("-l", "--list-types", "List keyword types") do
    puts KeywordMap.instance_methods(false).sort
    exit
  end

  opts.on("-f", "--file [path_to_file]", String, "Path to image") do |file|
    options[:path] = file
  end

  opts.on("-k", "--keywords [KEYWORDS]", Array, "Extra keywords") do |keywords|
    options[:keywords] = keywords
  end

  opts.on("-p", "--keywords-path [path_to_file]", Array, "Extra keywords file") do |keywords_path|
    options[:keywords_path] = keywords_path
  end
end.parse!

# Provide path to image as first argument
path_to_image = options[:path]

if !path_to_image
  puts "No image specified"
  exit
end

if !File.exists?(path_to_image)
  puts "File not found: #{path_to_image}"
  exit
end

exif = EXIFR::JPEG.new(path_to_image)
photo = MiniExiftool.new(path_to_image)

if !exif || !photo
  puts "No exif"
  exit
end

options_types = options[:types] || []
options_keywords = options[:keywords] || []
existing_keywords = photo.keywords || []
new_keywords = keyword_map.keywords_with_exif(exif, options_types, existing_keywords + options_keywords)

puts new_keywords
photo.keywords = new_keywords

puts 'Saving…'
photo.save

exit

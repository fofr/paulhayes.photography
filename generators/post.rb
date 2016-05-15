#!/usr/bin/ruby
gem 'exifr', '1.2.3.1'
require 'exifr'
require "./#{File.dirname(__FILE__)}/exif-helper.rb"
include ExifHelper

# Provide path to image as first argument
path_to_image = ARGV.first

unless path_to_image
  puts 'Usage: ruby generators/post.rb path/to/image.jpg'
  exit
end

exif = EXIFR::JPEG.new(path_to_image)

unless exif
  puts 'No exif found'
  exit
end

image = path_to_image.split('/').last
post = "./source/_posts/#{image.sub('.jpg', '.md')}"

def title(image)
  image.sub('.jpg', '').gsub('-', ' ').capitalize
end

if !File.exists?(post)
  content = "layout: photo
title: \"#{title(image)}\"
date: #{date(exif)}
flickr:
instagram:
500px:
natgeo:

exif: true
camera: \"#{camera(exif)}\"
lens: \"#{lens(exif)}\"
aperture: \"#{aperture(exif)}\"
shutter: \"#{shutter(exif)}\"
iso: #{iso(exif)}
focal: \"#{focal(exif)}\"

tags:
  -
---

"
  puts content
  File.open(post, 'w') do |f|
    f.write(content)
  end
else
  puts "#{post} already exists"
end

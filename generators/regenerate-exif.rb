#!/usr/bin/ruby
gem 'exifr', '1.2.3.1'
require 'exifr'
require "./#{File.dirname(__FILE__)}/exif-helper.rb"
include ExifHelper

# Get list of all posts
path_to_images = "#{Dir.pwd}/../paulhayes.photography-photos/"
posts = Dir.glob("source/_posts/photos/*.md")

posts.each do |post|
  post_contents = File.read(post)

  image = post.split('/').last.sub(/md$/, 'jpg')
  exif = EXIFR::JPEG.new("#{path_to_images}#{image}")

  # HDR images have partial EXIFs that don't work
  next unless exif && exif.date_time && exif.model

  post_contents.gsub!(/^iso:.*$/, "iso: #{iso(exif)}")
  post_contents.gsub!(/^aperture:.*$/, "aperture: \"#{aperture(exif)}\"")
  post_contents.gsub!(/^date:.*$/, "date: #{date(exif)}")
  post_contents.gsub!(/^lens:.*$/, "lens: \"#{lens(exif)}\"")
  post_contents.gsub!(/^focal:.*$/, "focal: \"#{focal(exif)}\"")
  post_contents.gsub!(/^shutter:.*$/, "shutter: \"#{shutter(exif)}\"")
  post_contents.gsub!(/^camera:.*$/, "camera: \"#{camera(exif)}\"")

  File.open(post, "w") {|file| file.puts post_contents }
end

exit

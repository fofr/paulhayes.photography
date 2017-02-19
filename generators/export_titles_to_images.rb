#!/usr/bin/ruby
gem 'mini_exiftool', '2.8.0'
require 'mini_exiftool'

# Get list of all posts
path_to_images = "#{Dir.pwd}/../paulhayes.photography-photos/"
posts = Dir.glob("source/_posts/photos/*.md")

posts.each do |post|
  post_contents = File.read(post)
  image = post.split('/').last.sub(/md$/, 'jpg')
  photo = MiniExiftool.new("#{path_to_images}#{image}")
  edited = false

  title = post_contents.lines.find {|l| l.include?('title:')}.gsub('title: ', '').gsub('"', '')

  if !photo.creator
    edited = true
    photo.creator = 'Paul Hayes'
  end

  if !photo.copyright_notice
    photo.copyright_notice = 'Paul Hayes www.paulhayes.photography'
    edited = true
  end

  if !photo.title && title
    photo.title = title
    edited = true
    puts "Photo #{image} title being set to: #{title}"
  else
    puts "Photo #{image} already has a title"
  end

  if edited
    puts "Saving changes to #{image}"
    photo.save
  end

  #exit
end

exit

require 'rubygems'
require 'rmagick'

path = "/Users/ytbryan/Desktop/clear_sky/image.png"
img =  Magick::Image.read(path).first
puts "#{img.rows}x#{img.columns}"
img.columns.times do |column|
  img.rows.times do |row|
    puts "processing {#{row+1},#{column+1}}"
    pix = img.scale(row+1, column+1)
    puts averageColor = pix.pixel_color(row+1,column+1)
    puts hue = averageColor.to_hsla.first
  end
end


#if you spot any mistake, send them to ytbryan@gmail.com :) 

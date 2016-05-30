require 'rubygems'
require 'rmagick'

#map to scale (any heat map)
map = "sample_2.png"

#scales map image to width: 853 and height: 479
map_image = Magick::Image.read(map).first
scaled_image = map_image.adaptive_resize(853, 479)

#base image
base_image = Magick::Image.read("base-853.png").first

#overlay scaled map to base and writes result to file
base_image.composite(scaled_image, 0, 0, Magick::OverCompositeOp).write("overlayed_#{map}")
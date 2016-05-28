require 'rubygems'
require 'rmagick'


=begin
blue = light rain /snow
green = light thunderstorms/moderate rain shower
yellow = moderate thunderstorms, rainshower
magenta to read = severe thunderstorm / flooding rain
=end

=begin
HSL color value:
360 : red
300 : purple
240 : blue
120 : green
60  : yellow
0   : red
=end

path = "/home/tan/Desktop/hey/dpsri_70km_2016052405450000dBR.dpsri.png"
img =  Magick::Image.read(path).first
hueArr = Array.new(img.rows) {Array.new(img.columns) }
img.rows.times do |row|
    img.columns.times do |column|
        #a 10x10 grid centered on coordinate x , y
        x = row - (10/2)
        y = column - (10/2)

        #create an Arr of all the pixel within the 10x10 square
        #constitute to build a new sub-image
        pixels_at_location = img.dispatch(x.to_i, y.to_i, 10, 10, "RGB")
        new_img = Magick::Image.constitute(10, 10, "RGB", pixels_at_location)

        #scale image to one pixel ,grab the average color and 
        # get the first hue value
        pix = new_img.scale(1,1)
        averageColor = pix.pixel_color(0,0)
        hueArr[row][column] = averageColor.to_hsla.first



    end
end


#testing for rain intensity at specific coordinate
x = gets.chomp.to_i
y = gets.chomp.to_i
value = hueArr[x][y]
puts value
if value < 60 || value > 240
    puts "heavy rain"
  
elsif value >=60 && value <150
    puts "moderate rain"
    
else
    puts "light"
end


#original code
=begin
puts "#{img.rows}x#{img.columns}"

img.columns.times do |column|

  img.rows.times do |row|

    puts "processing {#{row+1},#{column+1}}"
    pix = img.scale(row+1, column+1)

    averageColor = pix.pixel_color(row+1,column+1)
    hue = averageColor.to_hsla.first
    puts hue
    sleep(1)
 

  end

end
=end







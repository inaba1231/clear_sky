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
def hue(image_name)
    path = "/home/tan/clear_sky/#{image_name}"
    img =  Magick::Image.read(path).first
    hueArr = Array.new(img.rows) {Array.new(img.columns) }
    img.rows.times do |row|
        
        img.columns.times do |column|
            
            #a 10x10 grid centered on coordinate x , y
            x = row - (1/2)
            y = column - (1/2)

            #create an Arr of all the pixel within the 10x10 square
            #constitute to build a new sub-image
            pixels_at_location = img.dispatch(row, column, 1, 1, "RGB")
            new_img = Magick::Image.constitute(1, 1, "RGB", pixels_at_location)

            #scale image to one pixel ,grab the average color and 
            # get the first hue value
            pix = new_img.scale(1,1)
            averageColor = pix.pixel_color(0,0)
            areaHue = averageColor.to_hsla.first
        
            hueArr[row][column] = areaHue
        end
    end
    return hueArr
end

 

=begin
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






 
        #Testing and comparing hue value
        #First link is the formula,  Second link is the calculator
        #http://stackoverflow.com/questions/23090019/fastest-formula-to-get-hue-from-rgb
        #http://www.rapidtables.com/convert/color/rgb-to-hsl.htm

        puts "X coordinate : #{row},  Y coordinate : #{column}"
        #This extract 16 bit RGB color, convert it to 8 bit
        rgb = img.pixel_color(row, column)
        red = rgb.red / 257
        green = rgb.green / 257
        blue = rgb.blue / 257
        #Use the RGB value and first link to manually get the hue value at each coordinate
        puts "red=#{red} green=#{green} blue=#{blue}"
    
        #Manual calculation from RGB to HSL

        #get a range of 0-1 by dividing by 255. color range from 0-255
        r = red / 255.0
        g = green / 255.0
        b = blue / 255.0
        max = [r, g, b].max 
        min = [r, g, b].min 
        #max == 0 mean r g b = 0, there no heat/hue on that coordinate
        if max == 0
            puts "no hue value"
        else
            if max == r 
                
                hue = (g - b) / ( max - min)
            elsif max == g
                hue = 2.0 + (b - r) / (max - min)
            else
                 hue = 4.0 + (r - g) / (max - min)
            end

            hue*= 60.0
            hue+= 360.0 if hue < 0 
        
            puts "area hue: #{areaHue}"
            puts "manual hue: #{hue }"
            
        end
        sleep(0.5)
    
end
=end





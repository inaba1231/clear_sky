require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'active_record'
require 'pg'
require './sky'

#database setting in rails
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  database: 'clear_sky_development',
  username: 'tan',
  password: 'password1'
)

class Heatmap < ActiveRecord::Base
end



# Using Nokogiri to extract the time,date

# Using Nokogiri to extract the time,date

weather_link = 'http://www.weather.gov.sg/weather-rain-area-50km/'
html = Nokogiri::HTML(open(weather_link))
time_text = html.css('ul.list-unstyled').css('li').map { |e|  e['id']}.compact


time_text.each do |t|

  time = Time.parse(t)
  year = time.year
  month = time.strftime("%m")
  day = time.strftime("%d")
  hour = time.strftime("%H")
  min = time.strftime("%M")

  image_path = "http://www.weather.gov.sg/files/rainarea/50km/v2/dpsri_70km_#{year}#{month}#{day}#{hour}#{min}0000dBR.dpsri.png"
  image_name = image_path.split("v2/")[1]
  
  open(image_path) {|f|

    File.open("#{image_name}", "wb") do |file|

      file.puts f.read
    end
  }
  puts "#{image_name} is saved into the same directory"
  hueArr = hue(image_name).to_json
  Heatmap.create(timestamp: image_name, hue: hueArr)
  sleep(2)
  puts "#{image_name} and hueValues are stored inside DB"

end

 



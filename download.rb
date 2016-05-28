require 'rubygems'
require 'nokogiri'
require 'open-uri'


#retrieve time now  round off the minute to the nearest 5
timeNow = Time.now

#round off the minute to the nearest 5, create a new Time obj that exclude seconds
check = timeNow.min % 10
if check >= 5
	minute = timeNow.min - (check - 5)
	timeStamp = Time.new(timeNow.year,timeNow.month,timeNow.day, timeNow.hour, minute, 0, "+08:00")

else 
	timeStamp = Time.new(timeNow.year,timeNow.month,timeNow.day, timeNow.hour, 0, 0, "+08:00")
end

# store 19 5 minute interval time obj starting from 10 min ago in a arr
timeArr = Array.new
time = timeStamp - 600
for i in 0...19
  timeArr[i] = time
  time-= 300
end


#loop through the array and save each timestamp image of the rain
timeArr.each do |t|
  
  year = t.year
  month = t.strftime("%m")
  day = t.strftime("%d")
  hour = t.strftime("%H")
  min = t.strftime("%M")


  image_path = "http://www.weather.gov.sg/files/rainarea/50km/v2/dpsri_70km_#{year}#{month}#{day}#{hour}#{min}0000dBR.dpsri.png"
  image_name = image_path.split("v2/")[1]

  open(image_path) {|f|
    
    File.open("#{image_name}","wb") do |file|
      
      file.puts f.read
    end
  }

end



# Using Nokogiri to extract the time,date
=begin
weather_link = 'http://www.weather.gov.sg/weather-rain-area-50km/'
html = Nokogiri::HTML(open(weather_link))
time_text = html.css('ul.list-unstyled').css('li').map { |e|  e['id']}.compact

time_text.each do |t|
puts t
end
=end



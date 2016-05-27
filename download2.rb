require 'rubygems'
require 'nokogiri'
require 'open-uri'


#retrieve time now  round off the minute to the nearest 5
timeNow = Time.now

#round off the minute to the nearest 5, create a new Time obj that exclude seconds
check = timeNow.min % 10
if check % 10 == 0
	timeStamp = Time.new(timeNow.year,timeNow.month,timeNow.day, timeNow.hour,timeNow.min, 0, "+08:00")

elsif check >= 5
	minute = timeNow.min - (check - 5)
	timeStamp = Time.new(timeNow.year,timeNow.month,timeNow.day, timeNow.hour, minute, 0, "+08:00")

elsif check < 5
	minute = timeNow.min - check 
	timeStamp = Time.new(timeNow.year,timeNow.month,timeNow.day, timeNow.hour, minute, 0, "+08:00")
end


#start from 10min ago
timeStamp-= 600

#loop through the array and save each timestamp image of the rain
# boolean statement to ensure mining are looping
mining = true



# mine backward and save each timestmap image of the rain
# any exception will cause the program to sleep for 60 seconds before continuing

#loop through the array and save each timestamp image of the rain
while mining == true do

  begin
      year = timeStamp.year
      month = timeStamp.strftime("%m")
      day = timeStamp.strftime("%d")
      hour = timeStamp.strftime("%H")
      min = timeStamp.strftime("%M")

      image_path = "http://www.weather.gov.sg/files/rainarea/50km/v2/dpsri_70km_#{year}#{month}#{day}#{hour}#{min}0000dBR.dpsri.png"
      image_name = image_path.split("v2/")[1]

      open(image_path) {|f|
        
        File.open("#{image_name}", "wb") do |file|
          
          file.puts f.read
      end
    }
  rescue
    #exception, sleep and retry again just incase exception is not caused
    #by end of  tunnel/ invalid link
    sleep(60)
    retry
  end
    
  timeStamp-= 300
  sleep(10)

end



# Using Nokogiri to extract the time,date
=begin
weather_link = 'http://www.weather.gov.sg/weather-rain-area-50km/'
html = Nokogiri::HTML(open(weather_link))
time_text = html.css('ul.list-unstyled').css('li').map { |e|  e['id']}.compact

time_text.each do |t|
puts t
end
/
=end


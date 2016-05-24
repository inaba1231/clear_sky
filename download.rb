require 'open-uri'

path = "http://www.weather.gov.sg/files/rainarea/50km/v2/dpsri_70km_2016052318350000dBR.dpsri.png"
open(path) {|f|
   File.open("whatever_file.jpg","wb") do |file|
     file.puts f.read
   end
}

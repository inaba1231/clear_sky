#Clear Sky

Project Clear Sky uses heatmap from weather.gov.sg to analyse and extract real-time information of the sky for further analysis and 5 min weather forecast.

Currently, weather.gov.sg provides a 2-hour weather forecasting for areas within Singapore. This can be improved using the extracted data to answer two important questions:

Is area X raining now?
Is the sky clear or dark at area Y now?

## Potential Impact

- Businesses who need weather information for supply chain management
- Consumers and commuters who would wish to plan their journey
- Drivers and riders who wish to plan their journey
- Activity planning by schools, organisations and companies
- Complement data on other data-driven project ie. was outcome A caused by weather like rain that day?


## sky.rb

Sky.rb takes in a heatmap image and produces the pixel data of the heatmap.

`rub sky.rb`

## Modules required (Orbital Student take note)

- extend sky.rb to extract and calculate the sky intensity
- write a miner to retrieve more heatmaps from source
- create an api to serve these information
- build a front-end to display these information for demo or simple usage



#Ask the user for their location and store the

p "Where are you located?"
user_location = gets.chomp
p "You are in "+ user_location


#Using the Google Maps API to get the latitude and longtitue

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" +ENV.fetch("GMAPS_KEY")

require("open-uri")

raw_data = URI.open(gmaps_url).read

require("json")

parsed_data = JSON.parse(raw_data)

results_array = parsed_data.fetch("results")

first_result = results_array.at(0)

geo_hash = first_result.fetch("geometry")

loc_hash = geo_hash.fetch("location")

latitude = loc_hash.fetch("lat")
longtitude = loc_hash.fetch("lng")

p "Your location is #{latitude} and #{longtitude}"

#Get the weather at the users' coordinates from the Dark Sky API
darksky_url ="https://api.darksky.net/forecast/"+ ENV.fetch("DARK_SKY_KEY")+"/#{latitude},#{longtitude}"

# https://api.darksky.net/forecast/71174c5d293588d2f0ba4c0c7448bcfb/41.8887,-87.6355

darksky_raw_data = URI.open(darksky_url).read
darksky_parsed = JSON.parse(darksky_raw_data)

#Get the current temparature
darksky_currently = darksky_parsed.fetch("currently")
darksky_current_temp = darksky_currently.fetch("temperature")
p "The current temparature is #{darksky_current_temp}°F"

#Get the summary of the weather for the next hour
darksky_hourly= darksky_parsed.fetch("hourly")
darksky_hourly_summary=darksky_hourly.fetch("summary")

p darksky_hourly_summary

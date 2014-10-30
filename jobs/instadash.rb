require 'instagram'
 
# Instagram Client ID from http://instagram.com/developer
Instagram.configure do |config|
  config.client_id = '7242265456564acfb52d53590f3b5c80'
end
 
# Latitude, Longitude for location
instadash_location_lat = '37.7819203157895'
instadash_location_long = '-122.404401526284'
 
SCHEDULER.every '10m', :first_in => 0 do |job|
  photos = Instagram.media_search(instadash_location_lat,instadash_location_long)
  if photos
    photos.map! do |photo|
      { photo: "#{photo.images.low_resolution.url}" }
    end    
  end
  send_event('instadash', photos: photos)
end
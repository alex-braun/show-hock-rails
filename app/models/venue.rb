require 'unirest'

class Venue < ActiveRecord::Base
  def initialize(param)
    @venue = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/venues/' + @venue.to_s +
    '.json?apikey=' + ENV['songkick_key']),
    headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @clean = @body['resultsPage']['results']['venue']
    @lat = @clean['lat']
    @lng = @clean['lng']
    @clean[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/venues/' +
    @clean['id'].to_s + '/col4'
    if @lat == nil || @lng == nil
      @clean[:noCoords] = true
    #   @clean[:googleMapUrl] = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
    #   @lat.to_s + ',' + @lng.to_s +
    #   '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' +
    #   @lat.to_s + ',' + @lng.to_s + '&key=' + ENV['googleapi_key']
    # else

    end
    @result = { 'venue' => @clean }
  end
end

require 'unirest'

class Venue < ActiveRecord::Base
  def initialize(param)
    @api_key = Rails.application.secrets.songkick_key
    @venue = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/venues/' + @venue.to_s +
    '.json?apikey=' + @api_key),
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
    end
    @result = { 'venue' => @clean }
  end
end

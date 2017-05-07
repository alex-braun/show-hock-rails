require 'unirest'

class Venue < ActiveRecord::Base
  def initialize(param)
    @songkick_key = Rails.application.secrets.songkick_key
    @venue = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/venues/' + @venue.to_s +
    '.json?apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']['venue']
    @lat = @response['lat']
    @lng = @response['lng']
    @response[:display_name] = @response['displayName']
    @response[:metro_area] = @response['metroArea']
    @response[:image_url] =
    'https://images.sk-static.com/images/media/profile_images/venues/' +
    @response['id'].to_s + '/col4'
    if @lat.nil? || @lng.nil?
      @response[:no_coords] = true
    end
    @result = { 'venue' => @response }
  end
end

require 'unirest'
require 'addressable/uri'

class LocationGeo < ActiveRecord::Base
  def initialize(param)
    @songkick_key = Rails.application.secrets.songkick_key
    @lat = param.fetch(:lat).to_s
    @lng = param.fetch(:lng).to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?location=geo:' +
    @lat + ',' + @lng + '&per_page=100&apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']['location']
    @response.each_index do |i|
      @response[i][:metro_area] = @response[i]['metroArea']
      @location_id = @response[i]['metroArea']['id']
      @response[i][:id] = @location_id
    end
    @result = { 'location_geo' => @response }
  end
end

require 'unirest'
require 'addressable/uri'

class LocationGeo < ActiveRecord::Base

  def initialize(param)
    @lat = param.fetch(:lat).to_s
    @lng = param.fetch(:lng).to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?location=geo:' +
    @lat + ',' + @lng + '&per_page=100&apikey=' + ENV['songkick_key']),
      headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @clean = @body['resultsPage']['results']['location']
    @clean.each_index do |i|
      @location_id = @clean[i]['metroArea']['id']
      @clean[i][:id] = @location_id
    end
    @result = { 'location_geo' => @clean }
  end
end

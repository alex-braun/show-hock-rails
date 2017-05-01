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
    @clean = @body['resultsPage']['results']['location']
    @clean.each_index do |i|
      @clean[i][:metro_area] = @clean[i]['metroArea']
      @location_id = @clean[i]['metroArea']['id']
      @clean[i][:id] = @location_id
    end
    @result = { 'location_geo' => @clean }
  end
end

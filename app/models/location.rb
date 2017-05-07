require 'unirest'
require 'addressable/uri'

class Location < ActiveRecord::Base
  def initialize(param)
    @songkick_key = Rails.application.secrets.songkick_key
    @uri = Addressable::URI.parse(param)
    @client_ip_norm = @uri.normalize
    @client_ip = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?location=ip:' +
    @client_ip + '&per_page=50&apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']['location']
    @response.each_index do |i|
      @response[i][:metro_area] = @response[i]['metroArea']
      @location_id = @response[i]['metroArea']['id']
      @response[i][:id] = @location_id
    end
    @result = { 'location' => @response }
  end
end

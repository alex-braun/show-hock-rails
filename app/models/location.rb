require 'unirest'
require 'addressable/uri'

class Location < ActiveRecord::Base
  def initialize(param)
    @uri = Addressable::URI.parse(param)
    @client_ip_norm = @uri.normalize
    @client_ip = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?location=ip:' +
    @client_ip + '&per_page=50&apikey=' + ENV['songkick_key']),
      headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @clean = @body['resultsPage']['results']['location']
    @clean.each_index do |i|
      @location_id = @clean[i]['metroArea']['id']
      @clean[i][:id] = @location_id
    end
    @result = { 'location' => @clean }
  end
end
# Ua1DQXRC1So9StKN



# http://api.songkick.com/api/3.0/search/locations.json?location=geo:38.0297,-84.4947&per_page=50&apikey=Ua1DQXRC1So9StKN

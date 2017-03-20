require 'unirest'
require 'addressable/uri'

class Concert < ActiveRecord::Base
  def initialize(param)
  @uri = Addressable::URI.parse(param)
  @normalize = @uri.normalize
  @body = Unirest.get((
  'http://api.songkick.com/api/3.0/events/' + @normalize.to_s + '.json?apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
      }).body
  end

  def result
    @clean = @body['resultsPage']['results']['event']
      @clean['performance'].each_index do |j|
        @artist_url = @clean['performance'][j]['artist']
        @artist_url[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
        @artist_url['id'].to_s + '/huge_avatar'
      end
    @result = {
      'concert' => @clean
    }
  end
end

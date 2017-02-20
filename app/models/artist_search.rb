require 'unirest'
require 'addressable/uri'

class ArtistSearch
  def initialize(param)
    @uri = Addressable::URI.parse(param)
    @normalize = @uri.normalize
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/artists.json?query=' +
    @normalize.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:displayName] = "Sorry, we've found no artist
        by that name.  Please try again."
      @response[:id] = 204
      @response[:noMatch] = true
      @response[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
      @get_id.to_s + '/huge_avatar'
      @result = { 'artist_search' => [@response] }
    else
      @clean = @body['resultsPage']['results']['artist']
      @clean.each_index do |i|
        @clean[i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
        @clean[i]['id'].to_s + '/huge_avatar'
      end
      @result = { 'artist_search' => @clean }
    end
  end
end

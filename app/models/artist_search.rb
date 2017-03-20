require 'unirest'
require 'addressable/uri'

class ArtistSearch
  def initialize(param)
    @uri = Addressable::URI.parse(param)
    @artist = param
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
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
      @response[:id] = @artist.to_s
      @response[:noMatch] = true
      @response[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
      @get_id.to_s + '/huge_avatar'
      @meta = { 'artist' => @artist.to_s }
      @response[:meta] = @meta
      @result = { 'artist_search' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @artist.to_s
      @clean['artist'].each_index do |i|
        @clean['artist'][i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
        @clean['artist'][i]['id'].to_s + '/huge_avatar'
      end
      @meta = { 'artist' => @artist.to_s }
      @clean[:meta] = @meta
      @result = { 'artist_search' => @clean }
    end
  end
end

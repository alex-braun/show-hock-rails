require 'unirest'

class ArtistSearch
  def initialize(param)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/artists.json?query=' +
    param.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:displayName] = "Sorry, we've found no artist
        by that name.  Please try again."
      @response[:id] = "Sorry, we've found no artist
        by that name.  Please try again."
      @response[:noMatch] = true
      @result = { 'artist_search' => [@response] }
    else
      @clean = @body['resultsPage']['results']['artist']
      # @clean.each_index do |i|
      #   @clean[i][:id] = @clean[i]['metroArea']['id']
      # end
      @result = { 'artist_search' => @clean }
    end
  end
end

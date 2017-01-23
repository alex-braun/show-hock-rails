require 'unirest'

class RegionSearch
  def initialize(param)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?query=' +
    param.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:metroArea] = { 'displayName' => "Sorry, we've found no events
        in that region.  Please try another area." }
      @response[:id] = "Sorry, we've found no events in that region.
      Please try another area."
      @response[:noMatch] = true
      @result = { 'region_search' => [@response] }
    else
      @clean = @body['resultsPage']['results']['location']
      @clean.each_index do |i|
        @clean[i][:id] = @clean[i]['metroArea']['id']
      end
      @result = { 'region_search' => @clean }
    end
  end
end

require 'unirest'

class RegionSearch
  def initialize(param)
    @body = Unirest.get(('http://api.songkick.com/api/3.0/search/locations.json?query=' + param.to_s + '&apikey=Ua1DQXRC1So9StKN'),
      headers: {
      'Accept' => 'application/json'
      }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @displayName= "Sorry, we've found no events in that region.  Please try another area."
      @metroArea = {'displayName' => @displayName}
      @response[:metroArea] = @metroArea
      @response[:id] = "Sorry, we've found no events in that region.  Please try another area."
      @result = {
        'region_search' => [@response]
      }
    else
      @clean = @body['resultsPage']['results']['location']
      @clean.each_index do |i|
        @clean[i][:id] = @clean[i]['metroArea']['id']
      end
      @result = {
        'region_search' => @clean
      }
    end
    return @result
  end
end

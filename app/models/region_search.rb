require 'unirest'

class RegionSearch
  def initialize(param)
    @body = Unirest.get(('http://api.songkick.com/api/3.0/search/locations.json?query='+ param.to_s+'&apikey=Ua1DQXRC1So9StKN'),
      headers: {
              'Accept' => 'application/json'
              }).body
  end

  def result
    @clean = @body['resultsPage']['results']
    @result = {
      'regionsearches' => [@clean]
    }
    return @result
  end
end

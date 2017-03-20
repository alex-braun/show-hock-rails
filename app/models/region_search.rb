require 'unirest'
require 'addressable/uri'

class RegionSearch
  def initialize(param)
    @uri = Addressable::URI.parse(param)
    @normalize = @uri.normalize
    @param = param.to_s
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?query=' +
    @normalize.to_s + '&per_page=10&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @param.to_s
      @response[:noMatch] = true
      @displayName = { 'displayName' => @param.to_s }
      @metro = { 'metroArea' => @displayName,
                'noMatch' => true }
      @response[:location] = [@metro]
      @result = { 'region_search' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @param.to_s
      @clean['location'].each_index do |i|
        @clean['location'][i][:id] = @clean['location'][i]['metroArea']['id']
        @metroArea = @clean['location'][i]['metroArea']
        @lat = @clean['location'][i]['metroArea']['lat']
        @lng = @clean['location'][i]['metroArea']['lng']
        @metroArea[:googleMapUrl] = 'https://maps.googleapis.com/maps/api/staticmap?center=' + @lat.to_s + ',' + @lng.to_s + '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' + @lat.to_s + ',' + @lng.to_s + '&key=' + ENV['googleapi_key']
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 10.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @clean[:meta] = @meta
      @result = { 'region_search' => @clean, }
    end
  end
end

require 'unirest'
require 'addressable/uri'

class RegionSearch
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @googleapi_key = Rails.application.secrets.googleapi_key
    @region_name = params.fetch(:id)
    @uri = Addressable::URI.parse(@region_name.to_s)
    @normalize = @uri.normalize
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/locations.json?query=' +
    @normalize.to_s + '&page=' + @page.to_s + '&per_page=' +
    @per_page.to_s + '&apikey=' + @songkick_key),
                        headers: {
                          'Accept' => 'application/json'
                        }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @region_name.to_s
      @response[:no_match] = true
      @display_name = { 'displayName' => @region_name.to_s }
      @metro = { 'metroArea' => @display_name,
                 'noMatch' => true }
      @response[:location] = [@metro]
      @meta = {
        'total_pages' => 0,
        'current_page' => 1,
        'total_entries' => 0
      }
      @response[:meta] = @meta
      return @result = { 'region_search' => @response }
    else
      @response[:id] = @region_name.to_s
      @response['location'].each_index do |i|
        @response['location'][i][:type] = 'region'
        @response['location'][i][:id] = @response['location'][i]['metroArea']['id']
        @metro_area = @response['location'][i]['metroArea']
        @lat = @response['location'][i]['metroArea']['lat']
        @lng = @response['location'][i]['metroArea']['lng']
        @metro_area[:googleMapUrl] =
          'https://maps.googleapis.com/maps/api/staticmap?center=' +
          @lat.to_s + ',' + @lng.to_s +
          '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' +
          @lat.to_s + ',' + @lng.to_s + '&key=' + @googleapi_key
        @metro_area[:googleMapHDUrl] =
            'https://maps.googleapis.com/maps/api/staticmap?center=' +
            @lat.to_s + ',' + @lng.to_s +
            '&zoom=4&size=300x300&markers=size:mid%7Ccolor:red%7C' +
            @lat.to_s + ',' + @lng.to_s + '&key=' + @googleapi_key
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      @result = { 'region_search' => @response }
    end
  end
end

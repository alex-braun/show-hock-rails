require 'unirest'
require 'addressable/uri'

class VenueSearch < ActiveRecord::Base
  def initialize(param)
    @uri = Addressable::URI.parse(param)
    @venue_name = param
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/venues.json?query=' +
    @normalize.to_s + '&apikey=' + ENV['songkick_key']),
    headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:displayName] = "Sorry, we've found no venues matching that name. Please try again"
      @response[:id] = @venue_name.to_s
      @response[:noMatch] = true
      @meta = { 'venue_name' => @venue_name.to_s }
      @response[:meta] = @meta
      @venue = { 'id' => @venue_name.to_s }
      @response[:venue] = [@venue]
      @result = { 'venue_search' => @response }
    else
      @clean = @body['resultsPage']['results']
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @clean[:meta] = @meta
      @clean[:id] = @venue_name.to_s
      @clean['venue'].each_index do |i|
        @lat = @clean['venue'][i]['lat']
        @lng = @clean['venue'][i]['lng']
        if @lat != nil || @lng != nil
          @clean['venue'][i][:googleMapUrl] = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
          @lat.to_s + ',' + @lng.to_s +
          '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' +
          @lat.to_s + ',' + @lng.to_s + '&key=' + ENV['googleapi_key']
        else
          @clean['venue'][i][:noCoords] = true
        end
        @clean['venue'][i][:imageUrl] =
        'http://images.sk-static.com/images/media/profile_images/venues/' +
        @clean['venue'][i]['id'].to_s + '/col4'

      end
      @result = { 'venue_search' => @clean }
    end
  end
end

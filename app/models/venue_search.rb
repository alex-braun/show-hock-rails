require 'unirest'
require 'addressable/uri'

class VenueSearch < ActiveRecord::Base
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @googleapi_key = Rails.application.secrets.googleapi_key
    @venue_name = params.fetch(:id)
    @uri = Addressable::URI.parse(@venue_name.to_s)
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/venues.json?query=' +
    @normalize.to_s + '&per_page=' + @per_page.to_s + '&page=' +
    @page.to_s + '&apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @venue_name.to_s
      @response[:no_match] = true
      @display_name = { 'displayName' => @venue_name.to_s }
      @venue = { 'venue' => @display_name,
                 'noMatch' => true }
      @meta = {
        'venue_name' => @venue_name.to_s,
        'total_pages' => 0,
        'current_page' => 0,
        'total_entries' => 0
      }
      @response[:meta] = @meta
      @response[:venue] = [@venue]
      return @result = { 'venue_search' => @response }
    else
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] /
        @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      @response[:id] = @venue_name.to_s
      @response['venue'].each_index do |i|
        @response['venue'][i][:type] = 'venue'
        @lat = @response['venue'][i]['lat']
        @lng = @response['venue'][i]['lng']
        if !@lat.nil? || !@lng.nil?
          @response['venue'][i][:googleMapUrl] =
          'https://maps.googleapis.com/maps/api/staticmap?center=' +
          @lat.to_s + ',' + @lng.to_s +
          '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' +
          @lat.to_s + ',' + @lng.to_s + '&key=' + @googleapi_key
        else
          @response['venue'][i][:noCoords] = true
        end
        @response['venue'][i][:imageUrl] =
        'https://images.sk-static.com/images/media/profile_images/venues/' +
        @response['venue'][i]['id'].to_s + '/col4'
      end
      @result = { 'venue_search' => @response }
    end
  end
end

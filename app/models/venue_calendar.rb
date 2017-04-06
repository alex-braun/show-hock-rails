require 'unirest'

class VenueCalendar < ActiveRecord::Base
  def initialize(params)
    @venue = params.fetch(:id)
    @page = params.fetch(:page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/venues/' + @venue.to_s +
    '/calendar.json?apikey=' + ENV['songkick_key']),
    headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @event = { 'id' => @venue.to_f,
                'displayName' => 'No upcoming events found',
                'noEvents' => true }
      @response[:event] = [@event]
    else
      @response['event'].each_index do |i|
        @response['event'][i]['performance'].each_index do |j|
          @artist = @response['event'][i]['performance'][j]['artist']
          @artist[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      @response[:id] = @venue.to_f
    end
    @result = { 'venue_calendar' => @response }
  end
end
# @clean['event'].each_index do |i|
#   @clean['event'][i]['performance'].each_index do |j|
#     if @clean['event'][i]['performance'][j]['id'] == @get_id.to_f
#       @artist = @clean['event'][i]['performance'][j]['artist']
#     end
#     @assoc_artist = @clean['event'][i]['performance'][j]['artist']
#     if @assoc_artist['id'] == @get_id.to_f
#       @artist = @assoc_artist['displayName']
#     end
#     @assoc_artist[:imageUrl] =
#     'http://images.sk-static.com/images/media/profile_images/artists/' +
#     @assoc_artist['id'].to_s + '/huge_avatar'
#   end
#   if @clean['event'][i]['type'] == 'Festival'
#     @clean['event'][i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/events/' +
#     @clean['event'][i]['id'].to_s + '/huge_avatar'
#   end
# end













#
# require 'unirest'
# require 'addressable/uri'
#
# class VenueSearch < ActiveRecord::Base
#   def initialize(param)
#     @uri = Addressable::URI.parse(param)
#     @venue_name = param
#     @normalize = @uri.normalize
#     @normalize.to_s.gsub!('&', '%26')
#     @body = Unirest.get((
#     'http://api.songkick.com/api/3.0/search/venues.json?query=' +
#     @normalize.to_s + '&apikey=' + ENV['songkick_key']),
#     headers: { 'Accept' => 'application/json' } ).body
#   end
#
#   def result
#     @response = @body['resultsPage']['results']
#     if @response == {}
#       @response[:displayName] = "Sorry, we've found no venues matching that name. Please try again"
#       @response[:id] = @venue_name.to_s
#       @response[:noMatch] = true
#       @meta = { 'venue_name' => @venue_name.to_s }
#       @response[:meta] = @meta
#       @venue = { 'id' => @venue_name.to_s }
#       @response[:venue] = [@venue]
#       @result = { 'venue_search' => @response }
#     else
#       @clean = @body['resultsPage']['results']
#       @meta = {
#         'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
#         'current_page' => @body['resultsPage']['page'],
#         'total_entries' => @body['resultsPage']['totalEntries']
#       }
#       @clean[:meta] = @meta
#       @clean[:id] = @venue_name.to_s
#       @clean['venue'].each_index do |i|
#         @lat = @clean['venue'][i]['lat']
#         @lng = @clean['venue'][i]['lng']
#         if @lat != nil || @lng != nil
#           @clean['venue'][i][:googleMapUrl] = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
#           @lat.to_s + ',' + @lng.to_s +
#           '&zoom=4&size=100x100&markers=size:mid%7Ccolor:red%7C' +
#           @lat.to_s + ',' + @lng.to_s + '&key=' + ENV['googleapi_key']
#         else
#           @clean['venue'][i][:noCoords] = true
#         end
#         @clean['venue'][i][:imageUrl] =
#         'http://images.sk-static.com/images/media/profile_images/venues/' +
#         @clean['venue'][i]['id'].to_s + '/col4'
#
#       end
#       @result = { 'venue_search' => @clean }
#     end
#   end
# end

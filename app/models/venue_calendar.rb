require 'unirest'

class VenueCalendar < ActiveRecord::Base
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @venue = params.fetch(:id)
    @page = params.fetch(:page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/venues/' + @venue.to_s +
    '/calendar.json?apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @event = { 'displayName' => 'No upcoming events found',
                 'no_match' => true }
      @response[:event] = [@event]
      @response[:id] = @venue.to_f
    else
      @response['event'].each_index do |i|
        @response['event'][i]['performance'].each_index do |j|
          @artist = @response['event'][i]['performance'][j]['artist']
          @artist[:imageUrl] =
          'https://images.sk-static.com/images/media/profile_images/artists/' +
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

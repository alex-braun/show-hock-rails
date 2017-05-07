require 'unirest'
require 'addressable/uri'

class UpcomingEvent < ActiveRecord::Base
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @location = params.fetch(:location)
    @artist = params.fetch(:artist)
    @uri = Addressable::URI.parse(params.fetch(:artist))
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/events.json?apikey=' +
    @songkick_key + '&artist_name=' + @normalize.to_s +
    '&location=sk:' + @location),
                        headers: {
                          'Accept' => 'application/json'
                        }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @artist.to_s
      @response[:no_match] = true
      @artist_name = { 'display_name' => @artist.to_s }
      @artist_obj = { 'artist' => @artist_name }
      @response[:performance] = @artist_obj
      return @result = { 'upcoming_event' => [@response] }
    else
      @response = @body['resultsPage']['results']['event']
      @response.each_index do |i|
        @response[i][:display_name] = @response[i]['displayName']
        @response[i]['performance'].each_index do |j|
          @artist_name = @response[i]['performance'][j]['artist']
          @artist_name[:imageUrl] =
            'https://images.sk-static.com/images/media/profile_images/events/' +
            @artist_name['id'].to_s + '/huge_avatar'
        end
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'artist' => @artist.to_s,
        'clientLocation' => @body['resultsPage']['clientLocation']
      }
      @result = { 'upcoming_event' => @response,
                  'meta' => @meta }
    end
  end
end

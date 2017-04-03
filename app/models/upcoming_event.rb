require 'unirest'
require 'addressable/uri'

class UpcomingEvent < ActiveRecord::Base
  def initialize(params)
    @location = params.fetch(:location)
    @artist = params.fetch(:artist)
    @uri = Addressable::URI.parse(params.fetch(:artist))
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/events.json?apikey=' +
    ENV['songkick_key'] + '&artist_name=' + @normalize.to_s +
    '&location=ip:' + @location),
      headers: {
        'Accept' => 'application/json'
              }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @artist.to_s
      @response[:noMatch] = true
      @artist_name = { 'displayName' => @artist.to_s }
      @artist_obj = { 'artist' => @artist_name }
      @response[:performance] = @artist_obj
      @result = { 'upcoming_event' => [@response] }
    else
      @clean = @body['resultsPage']['results']['event']
      @clean.each_index do |i|
        @clean[i]['performance'].each_index do |j|
          @artist_name = @clean[i]['performance'][j]['artist']
          @artist_name[:imageUrl] =
            'http://images.sk-static.com/images/media/profile_images/events/' +
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

      # @result = { 'upcoming_event' => @clean }
      @result = { 'upcoming_event' => @clean,
                  'meta' => @meta }
    end
  end
end
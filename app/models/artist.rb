require 'unirest'

class Artist < ActiveRecord::Base
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @get_id = params.fetch(:id)
    @min_date = '&min_date=' + params.fetch(:min_date).to_s
    @max_date = '&max_date=' + params.fetch(:max_date).to_s
    if params.fetch(:min_date) == ''
      @min_date = ''
    end
    if params.fetch(:max_date) == ''
      @max_date = ''
    end
    @page = params.fetch(:page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/artists/' + @get_id.to_s +
    '/calendar.json?page=' + @page.to_s + @min_date + @max_date +
    '&apikey=' + @songkick_key),
                        headers: {
                          'Accept' => 'application/json'
                        }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @get_id.to_f
      @response[:no_match] = true
      @artist_name = { 'displayName' => 'No Events for the artist' }
      @event = { 'performance' => @artist_name,
                 'noMatch' => true }
      @response[:event] = [@event]
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'min_date' => @min_date,
        'max_date' => @max_date,
        'imageUrl' =>
        'https://images.sk-static.com/images/media/profile_images/artists/' +
        @get_id.to_s + '/huge_avatar'
      }
      @response[:meta] = @meta
      return @result = { 'artist' => @response }
    else
      @response[:id] = @get_id.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response['event'].each_index do |i|
        @response['event'][i]['performance'].each_index do |j|
          if @response['event'][i]['performance'][j]['id'] == @get_id.to_f
            @artist = @response['event'][i]['performance'][j]['artist']
          end
          @assoc_artist = @response['event'][i]['performance'][j]['artist']
          if @assoc_artist['id'] == @get_id.to_f
            @artist = @assoc_artist['displayName']
          end
          @assoc_artist[:imageUrl] =
          'https://images.sk-static.com/images/media/profile_images/artists/' +
          @assoc_artist['id'].to_s + '/huge_avatar'
        end
        if @response['event'][i]['type'] == 'Festival'
          @response['event'][i][:imageUrl] = 'https://images.sk-static.com/images/media/profile_images/events/' +
          @response['event'][i]['id'].to_s + '/huge_avatar'
        end
      end
      @response[:artist] = @artist
      @response[:meta] = @meta
      @result = {
        'artist' => @response
      }
    end
  end
end

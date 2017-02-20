require 'unirest'

class Artist < ActiveRecord::Base
  def initialize(params)
    @get_id = params.fetch(:get_id)
    @page = params.fetch(:page)
    @artist = params.fetch(:artist)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/artists/'+ @get_id.to_s + '/calendar.json?page=' + @page.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = 204
      @response[:noMatch] = true
      @artist_name = { 'displayName' => @artist.to_s }
      @response[:performance] = @artist_name
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'artist' => @artist.to_s,
        'imageUrl' => 'http://images.sk-static.com/images/media/profile_images/artists/' +
        @get_id.to_s + '/huge_avatar'
        # 'http://images.sk-static.com/images/media/profile_images/artists/' +
        # @artist['id'].to_s + '/huge_avatar'
      }
      @result = { 'artist' => [@response],
                  'meta' => @meta }
    else
      @clean = @body['resultsPage']['results']['event']
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'artist' => @artist.to_s
      }

      @clean.each_index do |i|
        @clean[i]['performance'].each_index do |j|
          @artist = @clean[i]['performance'][j]['artist']
          @artist[:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
        if @clean[i]['type'] == 'Festival'
          @clean[i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/events/' +
          @clean[i]['id'].to_s + '/huge_avatar'
        end
      end
      @result = {
        'artist' => @clean,
        'meta' => @meta
      }
    end
  end
end

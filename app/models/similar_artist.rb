require 'unirest'

class SimilarArtist < ActiveRecord::Base
  def initialize(params)
    @get_id = params.fetch(:get_id)
    @artist = params.fetch(:artist)
    @body = Unirest.get((
      'http://api.songkick.com/api/3.0/artists/' + @get_id.to_s + '/similar_artists.json?apikey=' + ENV['songkick_key']),
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
      # @response[:performance] = @artist_name
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'artist' => @artist.to_s
      }
      @result = { 'similar_artist' => [@response],
                  'meta' => @meta }
    else
      @clean = @body['resultsPage']['results']['artist']
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
        'artist' => @artist.to_s
      }

      @clean.each_index do |i|
        @id = @clean[i]['id']
        @clean[i][:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @id.to_s + '/huge_avatar'
      end
      @result = {
        'similar_artist' => @clean,
        'meta' => @meta
      }
    end
  end
end

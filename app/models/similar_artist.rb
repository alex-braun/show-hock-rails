require 'unirest'

class SimilarArtist < ActiveRecord::Base
  def initialize(param)
    @param = param
    # @artist = params.fetch(:artist)
    @body = Unirest.get((
      'http://api.songkick.com/api/3.0/artists/' + param.to_s + '/similar_artists.json?per_page=10&apikey=' + ENV['songkick_key']),
      headers: {
        'Accept' => 'application/json'
      }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @param.to_f
      @response[:noMatch] = true
      @artist_name = 'No similar artists listed'
      @artist = { 'displayName' => @artist_name,
                  'noMatch' => true }
      @response[:artist] = [@artist]

      # @response[:performance] = @artist_name
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 10.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries'],
      }
      @response[:meta] = @meta
      @result = { 'similar_artist' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @param.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 10.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @clean['artist'].each_index do |i|
        @id = @clean['artist'][i]['id']
        @clean['artist'][i][:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @id.to_s + '/huge_avatar'
      end
      @clean[:meta] = @meta
      @result = { 'similar_artist' => @clean }
    end
  end
end

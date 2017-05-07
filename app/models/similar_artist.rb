require 'unirest'

class SimilarArtist < ActiveRecord::Base
  def initialize(param)
    @songkick_key = Rails.application.secrets.songkick_key
    @param = param
    @body = Unirest.get((
      'http://api.songkick.com/api/3.0/artists/' + param.to_s +
      '/similar_artists.json?per_page=10&apikey=' + @songkick_key),
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
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 10.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      return @result = { 'similar_artist' => @response }
    else
      @response[:id] = @param.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 10.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response['artist'].each_index do |i|
        @id = @response['artist'][i]['id']
        @response['artist'][i][:imageUrl] =
          'https://images.sk-static.com/images/media/profile_images/artists/' +
          @id.to_s + '/huge_avatar'
      end
      @response[:meta] = @meta
      @result = { 'similar_artist' => @response }
    end
  end
end

require 'unirest'
require 'addressable/uri'

class ArtistSearch
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @artist = params.fetch(:id)
    @uri = Addressable::URI.parse(@artist.to_s)
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/artists.json?query=' +
    @normalize.to_s + '&page=' + @page.to_s + '&per_page=' +
    @per_page.to_s + '&apikey=' + @songkick_key),
                        headers: {
                          'Accept' => 'application/json'
                        }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @display_name = { 'displayName' => @artist.to_s }
      @response[:id] = @artist.to_s
      @response[:no_match] = true
      @band = { 'artist' => @display_name,
                'noMatch' => true }
      @response[:artist] = [@band]
      @meta = {
        'artist' => @artist.to_s,
        'total_pages' => 0,
        'current_page' => 1,
        'total_entries' => 0
      }
      @response[:meta] = @meta
      return @result = { 'artist_search' => @response }
    else
      @response[:id] = @artist.to_s
      @response['artist'].each_index do |i|
        @response['artist'][i][:type] = 'artist'
        @response['artist'][i][:imageUrl] = 'https://images.sk-static.com/images/media/profile_images/artists/' +
        @response['artist'][i]['id'].to_s + '/huge_avatar'
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] /
        @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      @result = { 'artist_search' => @response }
    end
  end
end

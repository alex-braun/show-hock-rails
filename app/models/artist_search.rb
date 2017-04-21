require 'unirest'
require 'addressable/uri'

class ArtistSearch
  def initialize(params)
    @api_key = Rails.application.secrets.songkick_key
    @artist = params.fetch(:id)
    @uri = Addressable::URI.parse(@artist.to_s)
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @normalize = @uri.normalize
    @normalize.to_s.gsub!('&', '%26')
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/search/artists.json?query=' +
    @normalize.to_s + '&page=' + @page.to_s + '&per_page=' + @per_page.to_s + '&apikey=' + @api_key),
    headers: { 'Accept' => 'application/json' } ).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      # @response[:displayName] = "Sorry, we've found no artist
      #   by that name.  Please try again.
      @displayName = { 'displayName' => @artist.to_s }
      @response[:id] = @artist.to_s
      @response[:noMatch] = true
      @band = { 'artist' => @displayName,
                'noMatch' => true }
      @response[:artist] = [@band]

      # @response[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
      # @get_id.to_s + '/huge_avatar'
      @meta = {
        'artist' => @artist.to_s,
        'total_pages' => 0,
        'current_page' => 1,
        'total_entries' => 0
      }

      @response[:meta] = @meta
      @result = { 'artist_search' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @artist.to_s
      @clean['artist'].each_index do |i|
        @clean['artist'][i][:type] = 'artist'
        @clean['artist'][i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
        @clean['artist'][i]['id'].to_s + '/huge_avatar'
      end
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @clean[:meta] = @meta
      @result = { 'artist_search' => @clean }
    end
  end
end

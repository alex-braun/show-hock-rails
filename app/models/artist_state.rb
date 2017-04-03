require 'unirest'

class ArtistState < ActiveRecord::Base
  def initialize(params)
    @get_id = params.fetch(:id)
    @user_loc = params.fetch(:user_loc)

    #
    # @get_id = params.fetch(:get_id)
    @page = params.fetch(:page)
    # @artist = params.fetch(:artist)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/artists/'+ @get_id.to_s + '/calendar.json?page=' + @page.to_s + '&per_page=' + @per_page.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @get_id.to_f
      @artist_name = { 'displayName' => "No Events within the user's state" }
      @event = { 'performance' => @artist_name,
                  'noMatch' => true }
      @response[:event] = [@event]
      # @meta = {
      #   'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
      #   'current_page' => @body['resultsPage']['page'],
      #   'total_entries' => @body['resultsPage']['totalEntries'],
      #   'imageUrl' => 'http://images.sk-static.com/images/media/profile_images/artists/' +
      #   @get_id.to_s + '/huge_avatar'
      # }
      # @response[:meta] = @meta
      @result = { 'artist' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @get_id.to_f
      # @meta = {
      #   'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
      #   'current_page' => @body['resultsPage']['page'],
      #   'total_entries' => @body['resultsPage']['totalEntries']
      # }

      @clean['event'].each_index do |i|
        @clean['event'][i]['performance'].each_index do |j|
          if @clean['event'][i]['performance'][j]['id'] == @get_id.to_f
            @artist = @clean['event'][i]['performance'][j]['artist']
          end
          @assoc_artist = @clean['event'][i]['performance'][j]['artist']
          if @assoc_artist['id'] == @get_id.to_f
            @artist = @assoc_artist['displayName']
          end
          @assoc_artist[:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @assoc_artist['id'].to_s + '/huge_avatar'
        end
        if @clean['event'][i]['type'] == 'Festival'
          @clean['event'][i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/events/' +
          @clean['event'][i]['id'].to_s + '/huge_avatar'
        end
      end
      @clean[:artist] = @artist
      @clean[:user_loc] = @user_loc.to_s
      # @clean[:meta] = @meta
      @result = {
        'artist_state' => @clean,
        # 'meta' => @meta
      }
    end
  end
end
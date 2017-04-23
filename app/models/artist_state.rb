require 'unirest'

class ArtistState < ActiveRecord::Base
  def initialize(params)
    @api_key = Rails.application.secrets.songkick_key
    @get_id = params.fetch(:id)
    @user_loc = params.fetch(:user_loc)
    @page = params.fetch(:page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/artists/' + @get_id.to_s +
    '/calendar.json?page=' + @page.to_s + '&per_page=' +
    @per_page.to_s + '&apikey=' + @api_key),
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
      @result = { 'artist' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @get_id.to_f

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
          'https://images.sk-static.com/images/media/profile_images/artists/' +
          @assoc_artist['id'].to_s + '/huge_avatar'
        end
        if @clean['event'][i]['type'] == 'Festival'
          @clean['event'][i][:imageUrl] = 'https://images.sk-static.com/images/media/profile_images/events/' +
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

require 'unirest'
require 'addressable/uri'

class Concert < ActiveRecord::Base
  def initialize(param)
    @songkick_key = Rails.application.secrets.songkick_key
    @uri = Addressable::URI.parse(param)
    @normalize = @uri.normalize
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/events/' + @normalize.to_s +
    '.json?apikey=' + @songkick_key),
                        headers: { 'Accept' => 'application/json' }).body
  end

  def result
    @response = @body['resultsPage']['results']['event']
    @response[:display_name] = @response['displayName']
    @response[:age_restriction] = @response['ageRestriction']
    @response[:image_url] =
    'https://images.sk-static.com/images/media/profile_images/events/' +
    @normalize.to_s + '/huge_avatar'
    @response['performance'].each_index do |j|
      @artist_url = @response['performance'][j]['artist']
      @artist_url[:image_url] =
      'https://images.sk-static.com/images/media/profile_images/artists/' +
      @artist_url['id'].to_s + '/huge_avatar'
    end
    @result = {
      'concert' => @response
    }
  end
end

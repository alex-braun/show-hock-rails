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
    @clean = @body['resultsPage']['results']['event']
    @clean[:display_name] = @clean['displayName']
    @clean[:image_url] =
    'https://images.sk-static.com/images/media/profile_images/events/' +
    @normalize.to_s + '/huge_avatar'
    @clean['performance'].each_index do |j|
      @artist_url = @clean['performance'][j]['artist']
      @artist_url[:image_url] =
      'https://images.sk-static.com/images/media/profile_images/artists/' +
      @artist_url['id'].to_s + '/huge_avatar'
    end
    @result = {
      'concert' => @clean
    }
  end
end

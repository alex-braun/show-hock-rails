require 'unirest'

class Region
  def initialize(params)
    @id = params.fetch(:id)
    @page = params.fetch(:page)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/metro_areas/' + @id.to_s +
    '/calendar.json?page=' + @page.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @id.to_f
      @response[:noMatch] = true
      @displayName = { 'displayName' => "The region id does not exist." }
      @metroArea = { 'metroArea' => @displayName}
      @response[:event] = [@metroArea]
      @result = { 'region' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @id.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
      }
      @clean[:meta] = @meta

      @clean['event'].each_index do |i|
        @clean['event'][i]['performance'].each_index do |j|
          @artist = @clean['event'][i]['performance'][j]['artist']
          @artist[:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
        if @clean['event'][i]['type'] == 'Festival'
          @clean['event'][i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/events/' +
          @clean['event'][i]['id'].to_s + '/huge_avatar'
        end
      end
      @result = { 'region' => @clean }
    end
  end
end

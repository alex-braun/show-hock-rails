require 'unirest'

class Region
  def initialize(params)
    @get_id = params.fetch(:get_id)
    @page = params.fetch(:page)
    @location = params.fetch(:location)
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/metro_areas/' + @get_id.to_s +
    '/calendar.json?page=' + @page.to_s + '&apikey=' + ENV['songkick_key']),
    headers: {
      'Accept' => 'application/json'
    }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = "Sorry, we've found no events in that region.
      Please try another area."
      @response[:metroArea] = { 'displayName' => "Sorry, we've found no events
        in that region.  Please try another area." }
      @response[:noMatch] = true
      @result = { 'region' => [@response] }
    else
      @clean = @body['resultsPage']['results']['event']
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / 50).ceil,
        'current_page' => @body['resultsPage']['page'],
        'location' => @location.to_s
      }

      @clean.each_index do |i|
        @clean[i]['performance'].each_index do |j|
          @artist = @clean[i]['performance'][j]['artist']
          @artist[:imageUrl] =
          'http://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
        if @clean[i]['type'] == 'Festival'
          @clean[i][:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/events/' +
          @clean[i]['id'].to_s + '/large_avatar'
        end
      end
      @result = {
        'region' => @clean,
        'meta' => @meta
      }
    end
  end
end

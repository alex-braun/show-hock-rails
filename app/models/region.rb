require 'unirest'

class Region
  def initialize(params)
    @id = params.fetch(:id)
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @min_date = '&min_date='+ params.fetch(:min_date)
    @max_date = '&max_date'+ params.fetch(:max_date)
    if params.fetch(:min_date).to_s.blank?
      @min_date = 'nothing'.to_s
    end
    if params.fetch(:max_date).to_s.blank?
      @max_date = 'nothing'.to_s
    end
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/metro_areas/' + @id.to_s() +
    '/calendar.json?page=' + @page.to_s() + '&per_page=' +
    @per_page.to_s() + '&apikey=' + ENV['songkick_key']),
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
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      @result = { 'region' => @response }
    else
      @clean = @body['resultsPage']['results']
      @clean[:id] = @id.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] / @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @clean[:meta] = @meta

      @clean['event'].each_index do |i|
        @first_performance = @clean['event'][i]['performance'].first
        unless @first_performance == nil
          @headline_artist = @first_performance['artist']['id']
          @clean['event'][i][:headlineArtist] = @headline_artist
        end
      end
      @clean['event'].each_index do |i|
        @venue_id = @clean['event'][i]['venue']['id']
        @clean['event'][i]['venue'][:venueImg] = 'http://images.sk-static.com/images/media/profile_images/venues/' + @venue_id.to_s + '/col4'
        @clean['event'][i]['performance'].each_index do |j|
          @artist = @clean['event'][i]['performance'][j]['artist']
          @artist[:imageUrl] = 'http://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
        if @clean['event'][i]['type'] == 'Festival'
          @clean['event'][i][:imageUrl] =
            'http://images.sk-static.com/images/media/profile_images/events/' +
            @clean['event'][i]['id'].to_s + '/huge_avatar'
        end
      end
      @result = { 'region' => @clean }
    end
  end
end

require 'unirest'

class Region
  def initialize(params)
    @songkick_key = Rails.application.secrets.songkick_key
    @id = params.fetch(:id)
    @page = params.fetch(:page)
    @per_page = params.fetch(:per_page)
    @min_date = '&min_date=' + params.fetch(:min_date).to_s
    @max_date = '&max_date=' + params.fetch(:max_date).to_s
    if params.fetch(:min_date).to_s.blank?
      @min_date = ''
    end
    if params.fetch(:max_date).to_s.blank?
      @max_date = ''
    end
    @body = Unirest.get((
    'http://api.songkick.com/api/3.0/metro_areas/' + @id.to_s +
    '/calendar.json?page=' + @page.to_s + '&per_page=' +
    @per_page.to_s + @min_date + @max_date + '&apikey=' + @songkick_key),
                        headers: {
                          'Accept' => 'application/json'
                        }).body
  end

  def result
    @response = @body['resultsPage']['results']
    if @response == {}
      @response[:id] = @id.to_f
      @response[:noMatch] = true
      @display_name = { 'displayName' => 'The region id does not exist.' }
      @metro_area = { 'metroArea' => @display_name }
      @response[:event] = [@metro_area]
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] /
        @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta
      return @result = { 'region' => @response }
    else
      @response[:id] = @id.to_f
      @meta = {
        'total_pages' => (@body['resultsPage']['totalEntries'] /
        @per_page.to_f).ceil,
        'current_page' => @body['resultsPage']['page'],
        'total_entries' => @body['resultsPage']['totalEntries']
      }
      @response[:meta] = @meta

      @response['event'].each_index do |i|
        @first_performance = @response['event'][i]['performance'].first
        unless @first_performance.nil?
          @headline_artist = @first_performance['artist']['id']
          @response['event'][i][:headlineArtist] = @headline_artist
        end
      end
      @response['event'].each_index do |i|
        @venue_id = @response['event'][i]['venue']['id']
        @response['event'][i]['venue'][:venueImg] = 'https://images.sk-static.com/images/media/profile_images/venues/' +
        @venue_id.to_s + '/col4'
        @response['event'][i]['performance'].each_index do |j|
          @artist = @response['event'][i]['performance'][j]['artist']
          @artist[:imageUrl] =
          'https://images.sk-static.com/images/media/profile_images/artists/' +
          @artist['id'].to_s + '/huge_avatar'
        end
        if @response['event'][i]['type'] == 'Festival'
          @response['event'][i][:imageUrl] =
            'https://images.sk-static.com/images/media/profile_images/events/' +
            @response['event'][i]['id'].to_s + '/huge_avatar'
        end
      end
      @result = { 'region' => @response }
    end
  end
end

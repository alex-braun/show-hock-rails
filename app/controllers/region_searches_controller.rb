class RegionSearchesController < ApplicationController
  before_action :set_region_search, only: [:show, :update, :destroy]

  def index
    @region_searches = RegionSearch.new(params[:search]).result

    if @region_searches['regionsearches'] == [{}]
      @message = {
        message: 'Sorry, no matches were found.  Please try another area.',
        id: 'Sorry, no matches were found.  Please try another area.'
      }
      render json: @region_searches = {
                  'regionsearches' => [@message] }
    else
      render json: @region_searches
    end
  end
end

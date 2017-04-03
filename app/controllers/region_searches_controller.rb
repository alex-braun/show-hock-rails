class RegionSearchesController < OpenReadController
  # before_action :set_region_search, only: [:show, :update, :destroy]

  # def index
  #   @region_searches = RegionSearch.new(params[:search]).result
  #   render json: @region_searches
  # end

  def show
    @region_searches = RegionSearch.new(params[:id]).result

    render json: @region_searches
  end
end

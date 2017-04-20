class RegionSearchesController < OpenReadController
  # before_action :set_region_search, only: [:show, :update, :destroy]

  # def index
  #   @region_searches = RegionSearch.new(params[:search]).result
  #   render json: @region_searches
  # end

  def show
    @region_searches = RegionSearch.new(id: params[:id], per_page: params[:per_page], page: params[:page]).result

    render json: @region_searches
  end
end

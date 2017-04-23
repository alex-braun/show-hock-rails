class RegionsController < OpenReadController
  # before_action :set_region, only: [:show, :update, :destroy]
  # def index
  #   @regions = Region.new(get_id: params[:getId],
  #   page: params[:page], location: params[:location]).result
  #   render json: @regions
  # end

  def show
    @regions = Region.new(id: params[:id], page: params[:page],
                          per_page: params[:per_page],
                          min_date: params[:min_date],
                          max_date: params[:max_date]).result

    render json: @regions
  end
end

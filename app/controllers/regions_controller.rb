class RegionsController < OpenReadController
  before_action :set_region, only: [:show, :update, :destroy]
  def index
    @regions = Region.new(get_id: params[:getId],
    page: params[:page], location: params[:location]).result
    render json: @regions
  end
end

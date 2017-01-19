class RegionsController < OpenReadController
  before_action :set_region, only: [:show, :update, :destroy]
  def index
    # @regions = Region.new(params[:getId], params[:page]).result
    @regions = Region.new(get_id: params[:getId], page: params[:page]).result
    render json: @regions
  end

    # private
    #
    # def region_search_params
    #   params.require(:region_search).permit(:id)
    # end
end

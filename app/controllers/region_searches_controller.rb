class RegionSearchesController < OpenReadController
  before_action :set_region_search, only: [:show, :update, :destroy]

  def index
    @region_searches = RegionSearch.new(params[:search]).result
    render json: @region_searches
  end

  # private
  #
  # def region_search_params
  #   params.require(:region_search).permit(:id)
  # end
end

# {
# "events": [
#   {
# "id": 1,
# "songkick_id": 28268869,
# "name": "Atlas Lab at The Middle East Downstairs (January 11, 2017)",
# "artists": [
#   "Atlas Lab",
#   "Fatty Lumpkins",
#   "Arbuckle and the Furious Philanderers"
# ],
# "location": "Cambridge, MA, US",
# "date": "2017-01-12T00:00:00.000Z",
# "user": {
# "id": 1,
# "email": "braunacb@gmail.com"
# }
# }
# ],
# }

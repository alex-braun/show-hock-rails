class VenueSearchesController < OpenReadController
  # before_action :set_venue_search, only: [:show, :update, :destroy]

  def show
    @venue_search = VenueSearch.new(id: params[:id],
                                    per_page: params[:per_page],
                                    page: params[:page]).result

    render json: @venue_search
  end
end

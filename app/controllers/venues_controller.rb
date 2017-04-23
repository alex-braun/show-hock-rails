class VenuesController < OpenReadController
  # before_action :set_venue, only: [:show, :update, :destroy]

  def show
    @venue = Venue.new(params[:id]).result

    render json: @venue
  end
end

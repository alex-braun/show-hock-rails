class VenuesController < OpenReadController
  # before_action :set_venue, only: [:show, :update, :destroy]

  # GET /venues
  # GET /venues.json
  # def index
  #   @venues = Venue.all
  #
  #   render json: @venues
  # end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.new(params[:id]).result

    render json: @venue
  end
end

  # POST /venues
  # POST /venues.json
  # def create
  #   @venue = Venue.new(venue_params)
  #
  #   if @venue.save
  #     render json: @venue, status: :created, location: @venue
  #   else
  #     render json: @venue.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  # def update
  #   @venue = Venue.find(params[:id])
  #
  #   if @venue.update(venue_params)
  #     head :no_content
  #   else
  #     render json: @venue.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /venues/1
  # DELETE /venues/1.json
#   def destroy
#     @venue.destroy
#
#     head :no_content
#   end
#
#   private
#
#     def set_venue
#       @venue = Venue.find(params[:id])
#     end
#
#     def venue_params
#       params[:venue]
#     end
# end

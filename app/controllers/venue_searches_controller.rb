class VenueSearchesController < OpenReadController
  # before_action :set_venue_search, only: [:show, :update, :destroy]

  # GET /venue_searches
  # GET /venue_searches.json
  # def index
  #   @venue_searches = VenueSearch.all
  #
  #   render json: @venue_searches
  # end

  # GET /venue_searches/1
  # GET /venue_searches/1.json
  def show
    @venue_search = VenueSearch.new(params[:id]).result

    render json: @venue_search
  end

  # POST /venue_searches
  # POST /venue_searches.json
  # def create
  #   @venue_search = VenueSearch.new(venue_search_params)
  #
  #   if @venue_search.save
  #     render json: @venue_search, status: :created, location: @venue_search
  #   else
  #     render json: @venue_search.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /venue_searches/1
  # PATCH/PUT /venue_searches/1.json
  # def update
  #   @venue_search = VenueSearch.find(params[:id])
  #
  #   if @venue_search.update(venue_search_params)
  #     head :no_content
  #   else
  #     render json: @venue_search.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /venue_searches/1
  # DELETE /venue_searches/1.json
  # def destroy
  #   @venue_search.destroy
  #
  #   head :no_content
  # end
  #
  # private
  #
  #   def set_venue_search
  #     @venue_search = VenueSearch.find(params[:id])
  #   end
  #
  #   def venue_search_params
  #     params[:venue_search]
  #   end
end

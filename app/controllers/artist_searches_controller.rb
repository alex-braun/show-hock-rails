class ArtistSearchesController < OpenReadController
  # before_action :set_artist_search, only: [:show, :update, :destroy]

  # GET /artist_searches
  # GET /artist_searches.json
  # def index
  #   @artist_searches = ArtistSearch.new(params[:id]).result
  #
  #   render json: @artist_searches
  # end

  def show
    @artist_searches = ArtistSearch.new(params[:id]).result

    render json: @artist_searches
  end

  # def set_artist_search
  #   @artist_searches = ArtistSearch.new(params[:id])
  #   # @cocktail = current_user.cocktails.find(params[:id])
  # end
end

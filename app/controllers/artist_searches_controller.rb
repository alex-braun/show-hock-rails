class ArtistSearchesController < OpenReadController
  before_action :set_artist_search, only: [:show, :update, :destroy]

  # GET /artist_searches
  # GET /artist_searches.json
  def index
    @artist_searches = ArtistSearch.new(params[:search]).result

    render json: @artist_searches
  end
end

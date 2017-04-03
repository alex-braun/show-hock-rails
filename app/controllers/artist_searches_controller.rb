class ArtistSearchesController < OpenReadController
  # before_action :set_artist_search, only: [:show, :update, :destroy]

  def show
    @artist_searches = ArtistSearch.new(params[:id]).result

    render json: @artist_searches
  end
end

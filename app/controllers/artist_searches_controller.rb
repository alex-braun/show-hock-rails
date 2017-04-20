class ArtistSearchesController < OpenReadController
  # before_action :set_artist_search, only: [:show, :update, :destroy]

  def show
    # @artist_searches = ArtistSearch.new(params[:id]).result
    # @artist_searches = ArtistSearch.new(params[:id]).result
    @artist_searches = ArtistSearch.new(id: params[:id], per_page: params[:per_page], page: params[:page]).result

    render json: @artist_searches
  end
end

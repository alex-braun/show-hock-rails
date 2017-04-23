class SimilarArtistsController < OpenReadController
  # before_action :set_similar_artist, only: [:show, :update, :destroy]

  def show
    @similar_artists = SimilarArtist.new(params[:id]).result

    render json: @similar_artists
  end
end

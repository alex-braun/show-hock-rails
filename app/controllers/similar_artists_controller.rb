class SimilarArtistsController < OpenReadController
  # before_action :set_similar_artist, only: [:show, :update, :destroy]

  # GET /similar_artists
  # GET /similar_artists.json
  # def index
  #   @similar_artists = SimilarArtist.new(get_id: params[:getId], artist: params[:artist]).result
  #
  #   render json: @similar_artists
  # end

  def show
    @similar_artists = SimilarArtist.new(params[:id]).result

    render json: @similar_artists
  end
end

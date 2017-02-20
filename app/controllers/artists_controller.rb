class ArtistsController < OpenReadController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.new(get_id: params[:getId],
    page: params[:page], artist: params[:artist]).result

    render json: @artists
  end
end

class ArtistsController < OpenReadController
  # before_action :set_artist, only: [:show, :update, :destroy]

  def show
    @artists = Artist.new(id: params[:id], page: params[:page]).result

    render json: @artists
  end
end

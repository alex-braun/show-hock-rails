class ArtistsController < OpenReadController
  # before_action :set_artist, only: [:show, :update, :destroy]

  def show
    @artists = Artist.new(id: params[:id], page: params[:page], min_date: params[:min_date], max_date: params[:max_date]).result

    render json: @artists
  end
end

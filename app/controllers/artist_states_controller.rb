class ArtistStatesController < OpenReadController
  # before_action :set_artist, only: [:show, :update, :destroy]

  def show
    @artist_state = ArtistState.new(id: params[:id], page: params[:page],
                                    user_loc: params[:user_loc]).result

    render json: @artist_state
  end
end

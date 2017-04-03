class ConcertsController < OpenReadController
  # before_action :set_concert, only: [:show, :update, :destroy]

  def show
    @concerts = Concert.new(params[:id]).result

    render json: @concerts
  end
end

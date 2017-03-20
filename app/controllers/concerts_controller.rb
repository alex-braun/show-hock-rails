class ConcertsController < OpenReadController
  # before_action :set_concert, only: [:show, :update, :destroy]

  # GET /concerts
  # GET /concerts.json
  # def index
  #   @concerts = Concert.new(params[:concertId]).result
  #
  #   render json: @concerts
  # end

  def show
    @concerts = Concert.new(params[:id]).result

    render json: @concerts
  end
end

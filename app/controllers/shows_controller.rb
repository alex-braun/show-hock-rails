class ShowsController < OpenReadController
  before_action :set_show, only: [:show, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all

    render json: @shows
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    render json: @show
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.create(show_params)

    if @show.valid?
      render json: @show, status: :created, location: @show
    else
      # render json: @show.errors, status: :unprocessable_entity
      render json: Show.where('event_id = :event_id', event_id: show_params[:event_id]), status: :im_used
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    @show = Show.find(params[:id])

    if @show.update(show_params)
      head :no_content
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy

    head :no_content
  end

  private

    def set_show
      @show = Show.find(params[:id])
    end

    def show_params
      params.require(:show).permit(:region_id, :region_name, :venue_id, :venue_name, :event_id, :event_name, :start, :end, :city, :state, :country)
    end
end

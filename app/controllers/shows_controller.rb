class ShowsController < OpenReadController
  before_action :set_show, only: [:show, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all
    # sorted = @shows.order(:end_date)
    render json: @shows
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    render json: @show
  end

  # POST /shows
  # POST /shows.json
  def errors

  end

  def create
    @show = Show.create(show_params)

    if @show.valid?
      render json: @show, status: :created, location: @show
    else

      @dupe = Show.where('event_id = :event_id', event_id: show_params[:event_id])

      render json: { errors: @dupe }, status: :found
      # render json: { errors: @show.errors }, status: :im_used
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
      params.require(:show).permit(:region_id, :region_name, :venue_id, :venue_name, :event_id, :event_name, :event_link, :city, :state, :country, :type, :expired, :start_date, :end_date)
    end
end

class CalendarsController < OpenReadController
  before_action :set_calendar, only: [:show, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = current_user.calendars.all
    # @calendars = Calendar.all

    render json: @calendars
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    render json: @calendar
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = current_user.calendars.build(calendar_params)

    if @calendar.save
      render json: @calendar, status: :created, location: @calendar
    else
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])

    if @calendar.update(calendar_params)
      head :no_content
    else
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy

    head :no_content
  end

  private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def calendar_params
      params.require(:calendar).permit(:show_id, :user_id, :event_id, :isDone)
    end
end

class VenueCalendarsController < OpenReadController
  # before_action :set_venue_calendar, only: [:show, :update, :destroy]

  # GET /venue_calendars
  # GET /venue_calendars.json
  # def index
  #   @venue_calendars = VenueCalendar.all
  #
  #   render json: @venue_calendars
  # end
  def show
    @venue_calendar = VenueCalendar.new(id: params[:id], page: params[:page]).result

    render json: @venue_calendar
  end
end

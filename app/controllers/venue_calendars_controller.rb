class VenueCalendarsController < OpenReadController
  # before_action :set_venue_calendar, only: [:show, :update, :destroy]

  def show
    @venue_calendar = VenueCalendar.new(id: params[:id],
                                        page: params[:page]).result

    render json: @venue_calendar
  end
end

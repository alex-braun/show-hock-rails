class UpcomingEventsController < OpenReadController
  before_action :set_upcoming_event, only: [:show, :update, :destroy]

  # GET /upcoming_events.json
  def index
    @upcoming_events = UpcomingEvent.new(artist: params[:artist],
                                         location: params[:location]).result

    render json: @upcoming_events
  end
end

class LocationsController < OpenReadController
  # before_action :set_location, only: [:show, :update, :destroy]

  def index
    @locations = Location.new(params[:ip]).result
    render json: @locations
  end

  def show
    @location = Location.new(params[:id]).result

    render json: @location
  end
end

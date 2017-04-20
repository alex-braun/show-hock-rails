class LocationGeosController < OpenReadController
  # before_action :set_location_geo, only: [:show, :update, :destroy]

  # GET /location_geos
  # GET /location_geos.json
  def index
    @location_geos = LocationGeo.new(lat: params[:lat], lng: params[:lng]).result

    render json: @location_geos
  end

  # GET /location_geos/1
  # GET /location_geos/1.json
  # def show
  #   render json: @location_geo
  # end
end

class LocationGeosController < OpenReadController
  # before_action :set_location_geo, only: [:show, :update, :destroy]

  # GET /location_geos.json
  def index
    @location_geos = LocationGeo.new(lat: params[:lat],
                                     lng: params[:lng]).result
    render json: @location_geos
  end
end

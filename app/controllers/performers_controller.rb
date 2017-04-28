class PerformersController < OpenReadController
  before_action :set_performer, only: [:show, :update, :destroy]

  # GET /performers
  # GET /performers.json
  def index
    @performers = Performer.all

    render json: @performers
  end

  # GET /performers/1
  # GET /performers/1.json
  def show
    render json: @performer
  end

  # POST /performers
  # POST /performers.json
  def create
    @performer = Performer.new(performer_params)

    if @performer.save
      render json: @performer, status: :created, location: @performer
    else
      render json: @performer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /performers/1
  # PATCH/PUT /performers/1.json
  def update
    @performer = Performer.find(params[:id])

    if @performer.update(performer_params)
      head :no_content
    else
      render json: @performer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performers/1
  # DELETE /performers/1.json
  def destroy
    @performer.destroy

    head :no_content
  end

  private

    def set_performer
      @performer = Performer.find(params[:id])
    end

    def performer_params
      params.require(:performer).permit(:artist_id, :artist_name, :artist_img, :show_id)
    end
end

class QualitiesController < ApplicationController
  before_action :set_quality, only: [:show, :update, :destroy]

  # GET /qualities
  def index
    @qualities = Quality.all

    render json: @qualities
  end

  # GET /qualities/1
  def show
    render json: @quality
  end

  # POST /qualities
  def create
    @quality = Quality.new(quality_params)

    if @quality.save
      render json: @quality, status: :created, location: @quality
    else
      render json: @quality.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /qualities/1
  def update
    if @quality.update(quality_params)
      render json: @quality
    else
      render json: @quality.errors, status: :unprocessable_entity
    end
  end

  # DELETE /qualities/1
  def destroy
    @quality.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quality
      @quality = Quality.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quality_params
      params.require(:quality).permit(:name, :description, :grade)
    end
end

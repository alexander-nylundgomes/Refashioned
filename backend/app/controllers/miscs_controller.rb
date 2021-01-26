class MiscsController < ApplicationController
  before_action :set_misc, only: [:show, :update, :destroy]

  # GET /miscs
  def index
    @miscs = Misc.all

    render json: @miscs
  end

  # GET /miscs/1
  def show
    render json: @misc
  end

  # POST /miscs
  def create
    @misc = Misc.new(misc_params)

    if @misc.save
      render json: @misc, status: :created, location: @misc
    else
      render json: @misc.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /miscs/1
  def update
    if @misc.update(misc_params)
      render json: @misc
    else
      render json: @misc.errors, status: :unprocessable_entity
    end
  end

  # DELETE /miscs/1
  def destroy
    @misc.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_misc
      @misc = Misc.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def misc_params
      params.require(:misc).permit(:value, :name)
    end
end

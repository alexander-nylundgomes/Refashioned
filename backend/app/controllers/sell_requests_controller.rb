class SellRequestsController < ApplicationController
  before_action :set_sell_request, only: [:show, :update, :destroy]

  # GET /sell_requests
  def index
    @sell_requests = SellRequest.all

    render json: @sell_requests
  end

  # GET /sell_requests/1
  def show
    render json: @sell_request
  end

  # POST /sell_requests
  def create

    file = params['image']
    #### saves file somewhere and saves path to file_path ####

    parsed_params = ActionController::Parameters.new({sell_request: JSON.parse(params['sell_request'])})
    validate_inputs()

    @sell_request = SellRequest.new(sell_request_params(parsed_params))

    if @sell_request.save
      render json: @sell_request, status: :created, location: @sell_request
    else
      render json: @sell_request.errors, status: :unprocessable_entity
    end
  end

  def validate_inputs()
    # params => {         
    # image: {....},
    # sell_request: {
      # firstname: "",
      # lastname: "", 
      # email: "",
      # phone: '+46' + "",
      # brand: "", 
      # condition: "",
      # file: "",
      # asking_price: ""
    # }       

    if File.size(params['image'])/(1024*1024) > 0.5
      raise "Unallowed image size" 
    end

    JSON.parse(params['sell_request']).each do |x|
      if x[1] == ""
        raise "Missing data"
      end
    end
  end

  # PATCH/PUT /sell_requests/1
  def update
    if @sell_request.update(sell_request_params)
      render json: @sell_request
    else
      render json: @sell_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sell_requests/1
  def destroy
    @sell_request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell_request
      @sell_request = SellRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_request_params(items = params)
      items.require(:sell_request).permit(:firstname, :lastname, :email, :phone, :brand, :condition, :file_path, :asking_price)
    end
end
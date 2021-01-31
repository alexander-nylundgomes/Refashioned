class DiscountCodesController < ApplicationController
  # before_action :set_discount_code, only: [:show, :update, :destroy]

  # GET /discount_codes
  def index
    @discount_codes = DiscountCode.all

    render json: @discount_codes
  end

  # GET /discount_codes/1
  def show
    render json: @discount_code
  end

  # POST /discount_codes
  def create
    @discount_code = DiscountCode.new(discount_code_params)

    if @discount_code.save
      render json: @discount_code, status: :created, location: @discount_code
    else
      render json: @discount_code.errors, status: :unprocessable_entity
    end
  end

  def tryCode
    discount = DiscountCode.select('discount_codes.required_value', 'discount_codes.value_in_cash', 'discount_codes.value_in_percent', 'discount_codes.value_in_shipping').where("amount > 0 AND code = ?", params['code'])
    
    render json: discount
  end

  # PATCH/PUT /discount_codes/1
  def update
    if @discount_code.update(discount_code_params)
      render json: @discount_code
    else
      render json: @discount_code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /discount_codes/1
  def destroy
    @discount_code.destroy
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_discount_code
  #     @discount_code = DiscountCode.find(params[:id])
  #   end

  #   # Only allow a trusted parameter "white list" through.
  #   def discount_code_params
  #     params.require(:discount_code).permit(:code, :amount)
  #   end
end

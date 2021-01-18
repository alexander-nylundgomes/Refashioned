class OrderdProductsController < ApplicationController
  before_action :set_orderd_product, only: [:show, :update, :destroy]

  # GET /orderd_products
  def index
    @orderd_products = OrderdProduct.all

    render json: @orderd_products
  end

  # GET /orderd_products/1
  def show
    render json: @orderd_product
  end

  # POST /orderd_products
  def create
    @orderd_product = OrderdProduct.new(orderd_product_params)

    if @orderd_product.save
      render json: @orderd_product, status: :created, location: @orderd_product
    else
      render json: @orderd_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orderd_products/1
  def update
    if @orderd_product.update(orderd_product_params)
      render json: @orderd_product
    else
      render json: @orderd_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orderd_products/1
  def destroy
    @orderd_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orderd_product
      @orderd_product = OrderdProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def orderd_product_params
      params.require(:orderd_product).permit(:product_id, :order_id)
    end
end

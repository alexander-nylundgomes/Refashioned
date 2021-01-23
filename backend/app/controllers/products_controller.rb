class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.select('products.*', 'products.id AS product_id', 'categories.cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).order('products.category_id')
    
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def validateStock

    render json: Product.where(id: params['products'])
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.select('products.*', 'products.id AS product_id', 'categories.cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:size, :desc, :color, :price, :name)
    end
end

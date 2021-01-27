class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.select('products.*', 'products.id AS product_id', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).order('products.category_id').where(bought: 0)
    
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  def search
    ## Gets products by name, category name and brand
    ## maybe multi word search? ex. "blue nike shirts"
    
    words = params[:tag].split(' ')
    products = Product.select('products.*', 'products.id AS product_id', 'categories.cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).where("products.name LIKE ? OR brands_name LIKE ? OR cat_name LIKE ?", "%#{words.first}%" , "%#{words.first}%" , "%#{words.first}%")

    # words.each do |search|
    #   queries = Array(search).map do |search_term|
    #     Product.select('products.*', 'products.id AS product_id', 'categories.cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).where('products.name LIKE :q OR brands_name LIKE :q OR cat_name LIKE :q', q: "%#{search_term}%")
    #   end

    #   statement = queries.reduce do |statement, query|
    #     statement.or(query)
    #   end

    #   puts statement

    #   @products = []
    #   @products.append(ActiveRecord::Base.connection.execute(statement.to_sql))

    # end


    render json: products
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

    render json: Product.where(id: params['products_id'], name: params['products_name'], bought: 0)
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.select('products.*', 'products.id AS product_id', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name').joins(:category, :brand).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:size, :desc, :color, :price, :name)
    end
end

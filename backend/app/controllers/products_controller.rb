require 'securerandom'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.select('products.*', 'products.id AS product_id', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name', 'qualities.description AS qualities_description', 'qualities.name AS quality_name', 'qualities.grade', 'colors.name AS color_name').joins(:category, :brand, :quality, :color).order('products.category_id').where(bought: false)
    
    render json: @products
  end

  # GET /all_products
  def all
    @products = Product.select('products.*', 'products.id AS product_id', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name', 'qualities.description AS qualities_description', 'qualities.name AS quality_name', 'qualities.grade', 'colors.name AS color_name').joins(:category, :brand, :quality, :color).order('products.category_id')
    
    render json: @products
  end

  # GET /products/1
  def show
    product = Product.select('products.*', 'products.id AS product_id', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name', 'qualities.description AS qualities_description', 'qualities.name AS quality_name', 'qualities.grade').joins(:category, :brand, :quality).where(bought: 0, id: params['id'])
    product_images = ProductImage.where(product_id: params['id'])
    render json: {product: product, product_imgs: product_images}
  end

  def search
    # Gets products by name, category name and brand
    # maybe multi word search? ex. "blue nike shirts"
    # TODO: Add search for tags
    
    words = params[:tag].split(' ')
    products = Product.select('products.*', 'products.id AS product_id', 'tags.id AS tag_id','tags.name AS tag_name', 'categories.name AS cat_name', 'categories.description', 'brands.id AS brand_id', 'brands.name AS brands_name', 'qualities.description AS qualities_description', 'qualities.name AS quality_name', 'qualities.grade').joins(:category, :brand, :tag, :quality).where("products.name LIKE ? OR brands_name LIKE ? OR cat_name LIKE ? OR tag_name LIKE ?", "%#{words.first}%", "%#{words.first}%", "%#{words.first}%" , "%#{words.first}%").where(bought: false).uniq

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
    file = params['main_img']
    name = SecureRandom.hex(20)
    parsed_params = ActionController::Parameters.new({product: JSON.parse(params['product'])})
    puts parsed_params, "asdasd"
    @product = Product.new(product_params(parsed_params))
    path = "#{ ENV['cloud_link'] }#{ @product.id }/#{ name }.jpg"
    Cloudinary::Uploader.upload(file, :public_id => name,  :unique_filename => false, :folder => "products/#{@product.id}/", :invalidate => true)
    @product.update(main_image: path)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    file = params['main_img']

    # Creating a new name in order to force cache to reload updated image
    newName = SecureRandom.hex(20)

    if file
      path = URI.parse(@product.main_image).path
      path.slice!("/#{ENV['cloud_name']}")
      path = File.join(File.dirname(path), File.basename(path, '.*'))
      result = Cloudinary::Uploader.destroy(path)
      Cloudinary::Uploader.upload(file, :public_id => newName,  :unique_filename => false, :folder => "products/#{@product.id}/", :invalidate => true)
    end

    parsed_params = ActionController::Parameters.new({product: JSON.parse(params['product'])})
    parsed_params['product']['main_image'] = "#{ENV['cloud_link']}#{@product.id}/#{newName}#{File.extname(file)}"
    puts parsed_params, "parsed"

    if @product.update(product_params(parsed_params))
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
    def product_params(items = params)
      items.require(:product).permit(:size, :desc, :color_id, :price, :name, :brand_id, :category_id, :bought, :old_price, :quality_id, :order_id, :main_image)
    end
end

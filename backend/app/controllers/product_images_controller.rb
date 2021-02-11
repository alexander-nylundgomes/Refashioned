class ProductImagesController < ApplicationController
  before_action :set_product_image, only: [:show, :update, :destroy]

  # GET /product_images
  def index
    @product_images = ProductImage.all

    render json: @product_images
  end

  # GET /product_images/1
  def show
    @product_images = ProductImage.where(product_id: params['id'])
    render json: @product_images
  end

  # POST /product_images
  def create
    file = params['file']
    parsed_params = ActionController::Parameters.new({product_image: JSON.parse(params['product_image'])})
    name = SecureRandom.hex(20)

    parsed_params['product_image']['path'] = "#{ ENV['cloud_link'] }#{ parsed_params['product_image']['product_id'] }/#{ name }.jpg"
    @product_image = ProductImage.new(product_image_params(parsed_params))

    if @product_image.save
      Cloudinary::Uploader.upload(file, :public_id => name,  :unique_filename => false, :folder => "products/#{@product_image.product_id}/", :invalidate => true)
      render json: @product_image, status: :created, location: @product_image
    else
      render json: @product_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_images/1
  def update 
    file = params['file']
    parsed_params = ActionController::Parameters.new({product_image: JSON.parse(params['product_image'])})
    name = SecureRandom.hex(20)

    parsed_params['product_image']['path'] = "#{ ENV['cloud_link'] }#{ @product_image.product_id }/#{ name }.jpg"

    if @product_image.update(product_image_params(parsed_params))
      Cloudinary::Uploader.upload(file, :public_id => name,  :unique_filename => false, :folder => "products/#{@product_image.product_id}/", :invalidate => true)
      render json: @product_image
    else
      render json: @product_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_images/1
  def destroy
    # TODO: Delete image from cloudinary
    @product_image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_image_params(items = params)
      items.require(:product_image).permit(:product_id, :path, :order)
    end
end

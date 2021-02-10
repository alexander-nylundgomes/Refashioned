class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags
  end

  # GET /tags/1
  def show
    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def update_product_tags
    Tag.where(product_id: params['id']).delete_all
    
    saves = []

    params['tags'].each do |t|
      saves << Tag.new({name: t['name'], product_id: params['id']})
    end

    Tag.transaction do
      saves.each do |x|
        x.save!
      end
    end
  end

  def product_tags

    render json: Tag.where(product_id: params['id'])
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:product_id, :name)
    end
end

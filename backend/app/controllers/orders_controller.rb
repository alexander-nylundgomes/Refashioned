require 'stripe'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]


  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    ids = []

    params['products'].each do |p|
      ids << p['id']
    end

    Product.where(id: ids).update(bought: 1)
    discount = getDiscountFromCode(params['discount_code'])
    
    params['order']['value'] = calculate_order_amount(ids, discount) 

    if discount == nil
      discount_id = nil
    else
      discount_id = discount['id']
      DiscountCode.where(id: discount_id).update(amount: discount['amount'] - 1)
    end

    params['order']['discount_id'] = discount_id
    @order = Order.new(order_params)
    if @order.save
      
      orderd_products = []

      ids.each do |i|
        orderd_products << OrderdProduct.new({product_id: i, order_id: @order.id})
      end

      OrderdProduct.transaction do
        orderd_products.each do |o|
          o.save!
        end
      end

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def create_payment
    Stripe.api_key = ENV['stripe_secret']

    # Validate discount
    discount = getDiscountFromCode(params['discount_code']['code'])

    #Calculating price
    price = calculate_order_amount(params['product_ids'], discount) 

    if price == 0
      # Could not locate all products
      render json: ["Could not locate products"], status: :unprocessable_entity
    else
      # Finds all products
      payment_intent = Stripe::PaymentIntent.create(
        amount: (price * 100).round,
        currency: 'sek'
      )

      render json: {
        clientSecret: payment_intent['client_secret']
      }
    end
  end

  def getDiscountFromCode(code)
    discount = DiscountCode.select('discount_codes.*').where(code: code).first
    return discount
  end

  def calculate_order_amount(product_ids, discount)
    # products_ids => [33,32,14]
    # discount => DiscountObject

    prices = Product.where(id: product_ids)
    val = 0

    if prices.length != product_ids.length
      # Missing items
      # TODO: Add error handling
      return
    else
      # Finds all items
      # TODO: Functionality for free shipping
      prices.each do |product|
        val = val += product.price
      end

      if discount != nil && val >= discount.required_value && discount.amount > 0

        puts discount.value_in_percent
        if discount.value_in_cash != nil
          val = val - discount.value_in_cash
        elsif discount.value_in_percent != nil
          val = (val * 1.0) * ( 1 - (discount.value_in_percent / 100.0) )
        elsif discount.value_in_shipping != nil
          val = val - Misc.where(name: "shippinCost").first.value
        end
        
      end
    end

    return val
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:value, :address, :city, :email, :phone, :firstname, :lastname, :postal, :tracking, :discount_id)
    end
end

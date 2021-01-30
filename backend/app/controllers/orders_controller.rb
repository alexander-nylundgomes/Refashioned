require 'stripe'
require 'prawn'
require 'combine_pdf'
require 'securerandom'

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

    products = Product.select('products.*').where(id: ids).update(bought: 1)
    discount = getDiscountFromCode(params['discount_code'])
    
    params['order']['value'] = calculate_order_amount(ids, discount) 

    if discount == nil
      discount_id = nil

      if params['order']['value'] >= Misc.where(name: "shippingBar").first.value
        shipping = 0
      else
        shipping = Misc.where(name: "shippingCost").first.value
      end
    else
      discount_id = discount['id']
      discount = DiscountCode.select('discount_codes.*').where(id: discount_id).update(amount: discount['amount'] - 1).first

      if discount.value_in_shipping != nil
        shipping = 0
      end
    end


    params['order']['discount_id'] = discount_id
    params['order']['shipping_cost'] = shipping

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

      p @order.shipping_cost, "##############"

      create_invoice(
        firstname: @order.firstname,
        lastname: @order.lastname,
        city: @order.city,
        adress: @order.address,
        email: @order.email,
        postal: @order.postal,
        phone: @order.phone,
        randomString: SecureRandom.hex(35),
        products: products,
        discount: discount,
        timestamp: Time.now,
        order_id: @order.id,
        shipping_cost: @order.shipping_cost,
        shipping_value: Misc.where(name: "shippingCost").first.value
      )

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
        clientSecret: payment_intent['client_secret'],
        value: price,
      }
    end
  end

  def create_invoice(adress: , shipping_value: , shipping_cost: nil,city: , postal: , email: , phone: , randomString: ,products: , discount: , firstname: , lastname: , timestamp: , order_id:)

    Prawn::Document.generate("./#{firstname}_#{randomString}.pdf") do
        full_amount_without_tax = 0
        full_amount_with_tax = 0
    
        bounding_box([200, cursor + 5 ], width: 210) do
          text "#{firstname}"
          move_down 14
          text "#{lastname}"
          move_down 14
          text "#{adress}"
          move_down 14
          text "#{postal}"
          move_down 14
          text "#{city}" 
          move_down 16
          text "#{timestamp}"
          move_down 17
          text "#{order_id}"
        end

        move_cursor_to 500

        bounding_box([-20, cursor], width: bounds.width + 20, height: 20) do
          bounding_box([0, bounds.height], width: 50, height: bounds.height) do
            text "ID", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50, bounds.height], width: 125, height: bounds.height) do
            text "Namn", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50 + 125, bounds.height], width: 75, height: bounds.height) do
            text "Moms (%)", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50 + 125 + 75, bounds.height], width: 100, height: bounds.height) do
            text "Pris exkl. moms", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50 + 125 + 75 + 100, bounds.height], width: 75, height: bounds.height) do
            text "Moms (kr)", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50 + 125 + 75 + 100 + 75, bounds.height], width: 100, height: bounds.height) do
            text "Pris inkl. moms", valign: :center, overflow: :shrink_to_fit
          end

          bounding_box([0 + 50 + 125 + 75 + 100 + 75 + 100, bounds.height], width: 50, height: bounds.height) do
            text "Antal", valign: :center, overflow: :shrink_to_fit
          end 
        end

        products.each do |x|
          price_with_tax = x.price.round(1)
          price_without_tax = (x.price / 1.25).round(1)
          tax = ((price_with_tax * 1.0) - price_without_tax).round(1)

          full_amount_with_tax += price_with_tax
          full_amount_without_tax += price_without_tax

          bounding_box([-20, cursor], width: bounds.width + 20, height: 20) do
            bounding_box([0, bounds.height], width: 50, height: bounds.height) do
              text "#{x.id}", valign: :center, overflow: :shrink_to_fit 
            end

            bounding_box([0 + 50, bounds.height], width: 125, height: bounds.height) do
              text "#{x.name}", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125, bounds.height], width: 75, height: bounds.height) do
              text "25%", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 , bounds.height], width: 100, height: bounds.height) do
              text "#{price_without_tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 , bounds.height], width: 75, height: bounds.height) do
              text "#{tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 + 75 , bounds.height], width: 100, height: bounds.height) do
              text "#{price_with_tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 + 75 + 100, bounds.height], width: 50, height: bounds.height) do
              text "1 st", valign: :center, overflow: :shrink_to_fit
            end
          end
        end

        if shipping_cost != nil
          price_with_tax = shipping_cost.round(1)
          price_without_tax = (shipping_cost / 1.25).round(1)
          tax = ((price_with_tax * 1.0) - price_without_tax).round(1)

          full_amount_with_tax += price_with_tax
          full_amount_without_tax += price_without_tax

          bounding_box([-20, cursor], width: bounds.width + 20, height: 20) do
            bounding_box([0, bounds.height], width: 50, height: bounds.height) do
              text "", valign: :center, overflow: :shrink_to_fit 
            end

            bounding_box([0 + 50, bounds.height], width: 125, height: bounds.height) do
              text "Fraktkostnad", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125, bounds.height], width: 75, height: bounds.height) do
              text "25%", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 , bounds.height], width: 100, height: bounds.height) do
              text "#{price_without_tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 , bounds.height], width: 75, height: bounds.height) do
              text "#{tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 + 75 , bounds.height], width: 100, height: bounds.height) do
              text "#{price_with_tax} kr", valign: :center, overflow: :shrink_to_fit
            end

            bounding_box([0 + 50 + 125 + 75 + 100 + 75 + 100, bounds.height], width: 50, height: bounds.height) do
              text "1 st", valign: :center, overflow: :shrink_to_fit
            end
          end
        end

        if discount != nil
          if discount.value_in_shipping != nil
            discount_text = 'Gratis frakt'
            discount_amount = 0
          elsif discount.value_in_cash != nil
            discount_text = "#{discount.value_in_cash} kr"
            discount_amount = discount.value_in_cash
          elsif discount.value_in_percent != nil
            value = full_amount_with_tax * (discount.value_in_percent / 100.0)
            discount_text = "#{value.round(1)} kr (#{discount.value_in_percent}%)"
            discount_amount = value.round(1)
          end
        else
          discount_text = "Ingen rabatt"
          discount_amount = 0
        end

        move_down 200
        fill_color 'e6e6e6'
        fill_rectangle [-20,cursor], bounds.width + 20, 200
        fill_color '000000'
        bounding_box([0, cursor], width: bounds.width + 20, height: 150) do
          move_down 20
          text "Belopp utan moms:    #{full_amount_without_tax.round(1)} kr"
          move_down 14
          text "Belopp med moms:     #{full_amount_with_tax} kr"
          move_down 14
          text "Total moms:     #{(full_amount_with_tax - full_amount_without_tax).round(1)} kr"
          move_down 14
          text "Rabatt summa:    #{discount_text}"
          move_down 14
          text "Totalt betalat belopp: #{(full_amount_with_tax - discount_amount).round(1)} kr"
        end
    end

    addings = CombinePDF.load("./#{firstname}_#{randomString}.pdf").pages[0]
    pdf = CombinePDF.load("./receipt_layout.pdf",  allow_optional_content: true)
    pdf.pages.each {|page| page << addings} # notice the << operator is on a page and not a PDF object.

    # output the new pdf which now contains your dynamic data
    pdf.save "./#{firstname}_#{randomString}.pdf"
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
        val += product.price
      end

      if val >= Misc.where(name: "shippingBar").first.value
        shipping = 0
      else
        shipping = Misc.where(name: "shippingCost").first.value
      end

      if discount != nil && val >= discount.required_value && discount.amount > 0

        if discount.value_in_cash != nil
          val = val - discount.value_in_cash
        elsif discount.value_in_percent != nil
          val = (val * 1.0) * ( 1 - (discount.value_in_percent / 100.0) )
        elsif discount.value_in_shipping != nil
          # Give free shipping
          shipping = 0;
        end
      end
    end

    return val + shipping
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
      params.require(:order).permit(:shipping_cost, :value, :address, :city, :email, :phone, :firstname, :lastname, :postal, :tracking, :discount_id)
    end
end

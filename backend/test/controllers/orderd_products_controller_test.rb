require 'test_helper'

class OrderdProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orderd_product = orderd_products(:one)
  end

  test "should get index" do
    get orderd_products_url, as: :json
    assert_response :success
  end

  test "should create orderd_product" do
    assert_difference('OrderdProduct.count') do
      post orderd_products_url, params: { orderd_product: { order_id: @orderd_product.order_id, product_id: @orderd_product.product_id } }, as: :json
    end

    assert_response 201
  end

  test "should show orderd_product" do
    get orderd_product_url(@orderd_product), as: :json
    assert_response :success
  end

  test "should update orderd_product" do
    patch orderd_product_url(@orderd_product), params: { orderd_product: { order_id: @orderd_product.order_id, product_id: @orderd_product.product_id } }, as: :json
    assert_response 200
  end

  test "should destroy orderd_product" do
    assert_difference('OrderdProduct.count', -1) do
      delete orderd_product_url(@orderd_product), as: :json
    end

    assert_response 204
  end
end

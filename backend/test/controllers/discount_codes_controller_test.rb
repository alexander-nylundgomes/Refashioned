require 'test_helper'

class DiscountCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discount_code = discount_codes(:one)
  end

  test "should get index" do
    get discount_codes_url, as: :json
    assert_response :success
  end

  test "should create discount_code" do
    assert_difference('DiscountCode.count') do
      post discount_codes_url, params: { discount_code: { amount: @discount_code.amount, code: @discount_code.code } }, as: :json
    end

    assert_response 201
  end

  test "should show discount_code" do
    get discount_code_url(@discount_code), as: :json
    assert_response :success
  end

  test "should update discount_code" do
    patch discount_code_url(@discount_code), params: { discount_code: { amount: @discount_code.amount, code: @discount_code.code } }, as: :json
    assert_response 200
  end

  test "should destroy discount_code" do
    assert_difference('DiscountCode.count', -1) do
      delete discount_code_url(@discount_code), as: :json
    end

    assert_response 204
  end
end

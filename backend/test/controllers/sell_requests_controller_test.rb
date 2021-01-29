require 'test_helper'

class SellRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sell_request = sell_requests(:one)
  end

  test "should get index" do
    get sell_requests_url, as: :json
    assert_response :success
  end

  test "should create sell_request" do
    assert_difference('SellRequest.count') do
      post sell_requests_url, params: { sell_request: { asking_price: @sell_request.asking_price, brand: @sell_request.brand, condition: @sell_request.condition, email: @sell_request.email, file_path: @sell_request.file_path, firstname: @sell_request.firstname, lastname: @sell_request.lastname, phone: @sell_request.phone } }, as: :json
    end

    assert_response 201
  end

  test "should show sell_request" do
    get sell_request_url(@sell_request), as: :json
    assert_response :success
  end

  test "should update sell_request" do
    patch sell_request_url(@sell_request), params: { sell_request: { asking_price: @sell_request.asking_price, brand: @sell_request.brand, condition: @sell_request.condition, email: @sell_request.email, file_path: @sell_request.file_path, firstname: @sell_request.firstname, lastname: @sell_request.lastname, phone: @sell_request.phone } }, as: :json
    assert_response 200
  end

  test "should destroy sell_request" do
    assert_difference('SellRequest.count', -1) do
      delete sell_request_url(@sell_request), as: :json
    end

    assert_response 204
  end
end

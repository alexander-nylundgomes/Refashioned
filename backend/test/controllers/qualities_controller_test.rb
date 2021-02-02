require 'test_helper'

class QualitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quality = qualities(:one)
  end

  test "should get index" do
    get qualities_url, as: :json
    assert_response :success
  end

  test "should create quality" do
    assert_difference('Quality.count') do
      post qualities_url, params: { quality: { description: @quality.description, name: @quality.name } }, as: :json
    end

    assert_response 201
  end

  test "should show quality" do
    get quality_url(@quality), as: :json
    assert_response :success
  end

  test "should update quality" do
    patch quality_url(@quality), params: { quality: { description: @quality.description, name: @quality.name } }, as: :json
    assert_response 200
  end

  test "should destroy quality" do
    assert_difference('Quality.count', -1) do
      delete quality_url(@quality), as: :json
    end

    assert_response 204
  end
end

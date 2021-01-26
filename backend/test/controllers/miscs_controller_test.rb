require 'test_helper'

class MiscsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @misc = miscs(:one)
  end

  test "should get index" do
    get miscs_url, as: :json
    assert_response :success
  end

  test "should create misc" do
    assert_difference('Misc.count') do
      post miscs_url, params: { misc: { name: @misc.name, value: @misc.value } }, as: :json
    end

    assert_response 201
  end

  test "should show misc" do
    get misc_url(@misc), as: :json
    assert_response :success
  end

  test "should update misc" do
    patch misc_url(@misc), params: { misc: { name: @misc.name, value: @misc.value } }, as: :json
    assert_response 200
  end

  test "should destroy misc" do
    assert_difference('Misc.count', -1) do
      delete misc_url(@misc), as: :json
    end

    assert_response 204
  end
end

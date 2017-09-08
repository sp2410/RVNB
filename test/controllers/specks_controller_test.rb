require 'test_helper'

class SpecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @speck = specks(:one)
  end

  test "should get index" do
    get specks_url
    assert_response :success
  end

  test "should get new" do
    get new_speck_url
    assert_response :success
  end

  test "should create speck" do
    assert_difference('Speck.count') do
      post specks_url, params: { speck: { name: @speck.name } }
    end

    assert_redirected_to speck_url(Speck.last)
  end

  test "should show speck" do
    get speck_url(@speck)
    assert_response :success
  end

  test "should get edit" do
    get edit_speck_url(@speck)
    assert_response :success
  end

  test "should update speck" do
    patch speck_url(@speck), params: { speck: { name: @speck.name } }
    assert_redirected_to speck_url(@speck)
  end

  test "should destroy speck" do
    assert_difference('Speck.count', -1) do
      delete speck_url(@speck)
    end

    assert_redirected_to specks_url
  end
end

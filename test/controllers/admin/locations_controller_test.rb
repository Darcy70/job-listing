require 'test_helper'

class Admin::LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_locations_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_locations_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_locations_new_url
    assert_response :success
  end

end

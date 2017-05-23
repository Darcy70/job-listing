require 'test_helper'

class Account::CollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_collections_index_url
    assert_response :success
  end

end

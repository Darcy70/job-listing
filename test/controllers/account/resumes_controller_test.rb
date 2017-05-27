require 'test_helper'

class Account::ResumesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_resumes_index_url
    assert_response :success
  end

end

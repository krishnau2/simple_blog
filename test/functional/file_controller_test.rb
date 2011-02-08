require 'test_helper'

class FileControllerTest < ActionController::TestCase
  test "should get uploads" do
    get :upload
    assert_response :success
  end

end

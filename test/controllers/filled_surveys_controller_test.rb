require 'test_helper'

class FilledSurveysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get filled_surveys_new_url
    assert_response :success
  end

  test "should get create" do
    get filled_surveys_create_url
    assert_response :success
  end

end

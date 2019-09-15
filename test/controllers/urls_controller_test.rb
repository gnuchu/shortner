require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url = Url.new target: 'https://www.fcstpauli.com/en/'
  end

  test "should get index" do
    get api_v1_urls_url, as: :json
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post api_v1_urls_url, params: { url: { target: @url.target } }, as: :json
    end

    assert_response 201
  end

  test "should show url" do
    get api_v1_urls_url(@url), as: :json
    assert_response :success
  end

  test "should update url" do
    @url = Url.find_by target: 'https://xkcd.com'
    @url.target = 'http://newtarget.co.uk'
    
    patch api_v1_url_url(@url), params: { url: { target: @url.target } }, as: :json
    assert_response 200
  end
  
  test "should destroy url" do
    @url = Url.find_by target: 'https://xkcd.com'

    assert_difference('Url.count', -1) do
      delete api_v1_url_url(@url), as: :json
    end

    assert_response 204
  end
end

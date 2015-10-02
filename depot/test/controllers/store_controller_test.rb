require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 4
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /=N=[,\d]+\.\d\d/
  end

  test "Should confirm session[:counter]'s existence" do
    get :index
    assert session[:counter].nil? == false, ':::The counter session is not nil'
  end

  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select '.store .entry > img', :minimum => 3, :message => ":::More than 3 Images"
    assert_select '.entry input[type=submit]', :minimum => 3
  end

end

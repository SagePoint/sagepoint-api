require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
	test "should get new" do
		get :new
		assert_response :success
	end

	test "should login" do
		testAdminUser = users(:one)
		post :create, name: testAdminUser.email, password: 'secret' assert_redirected_to secure_url
		assert_equal testAdminUser.id, session[:user_id]
	end

	test "should fail login" do
		testAdminUser = users(:one)
		post :create, name: testAdminUser.email, password: 'wrong'
		assert_redirected_to login_url
	end

	test "should logout" do
		delete :destroy
		assert_redirected_to '/'
	end
end

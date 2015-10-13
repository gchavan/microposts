require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password"}
    end
    assert_template 'users/show'
    assert_equal flash[:success], 'Welcome to the Microposts App!', 'Successful sign-up message should have been here'
    assert is_logged_in?
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "Invalid User",
                     email: 'invaliduser@gmail.com',
                     password: 'foo',
                     password_confirmation: 'bar'}
    end
    assert_template 'users/new'
    assert_select 'div#error-explanation'
    assert_select 'div.alert-danger'
  end
end
require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test 'sign up user' do
    username = 'dan'
    get signup_path
    assert_response :success
    assert_difference('User.count', 1) do
      post users_path, params: { user: {
        username: username,
        email: 'dan@example.com',
        password: 'password'
      } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match(
      "Welcome to the Alpha Blog #{username}, you have successfully signed up!",
      response.body
    )
  end
end

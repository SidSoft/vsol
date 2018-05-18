require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dummy)
  end

  test "unsuccessful edit" do
    get new_user_path(@user)
    assert_template 'users/new'
    patch user_path(@user), user: {name: '',
                                   email: 'foo@invalid',
                                   password: 'foo',
                                   password_confirmation: 'bar'}
    assert_template 'users/new'
  end

  test "successful edit" do
    get new_user_path(@user)
    assert_template 'users/new'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: {name: name,
                                   email: email,
                                   password: "",
                                   password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has a name" do
    user = User.new(name: " ", email: "lol@gmail.com")
    assert_not user.valid?
  end

  test "name is within limits" do
    name = 'a' * 20
    user = User.new(name: name, email: "lol@gmail.com")
    assert user.valid?

    name = 'a' * 21
    user = User.new(name: name, email: "lol@gmail.com")
    assert_not user.valid?
  end
end

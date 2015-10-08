require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "has a title" do
    post = Post.new(title: " ", user_id: 1, text: "Insert text here")
    assert_not post.valid?
  end

  test "title is within limits" do
    title = 'a' * 20
    post = Post.new(title: title, user_id: 1, text: "Tetx")
    assert post.valid?

    title = 'a' * 21
    post = Post.new(title: title, user_id: 1, text: "Tetx")
    assert_not post.valid?
  end

  test "has text" do
    post = Post.new(title: "title", user_id: 1, text: " ")
    assert_not post.valid?
  end

  test "text is within limits" do
    text = 'a' * 256
    post = Post.new(title: "title", user_id: 1, text: text)
    assert_not post.valid?
  end

  test "must have a user_id" do
    post = Post.new(title: "title", text: "text")
    assert_not post.valid?
  end
end

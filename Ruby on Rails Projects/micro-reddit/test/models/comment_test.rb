require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "user_id must be present" do
    comment = Comment.new(text: "LOL THAT WAS SUPER FUNNY", post_id: 1)
    assert_not comment.valid?
  end

  test "post_id must be present" do
    comment = Comment.new(text: "LOL THAT WAS SUPER FUNNY", user_id: 2)
    assert_not comment.valid?
  end

  test "text is within limits" do
    text = 'a' * 50
    comment = Comment.new(text: text, user_id: 2, post_id: 1)
    assert comment.valid?
    text += 'a'
    comment = Comment.new(text: text, user_id: 2, post_id: 1)
    assert_not comment.valid?
  end
end

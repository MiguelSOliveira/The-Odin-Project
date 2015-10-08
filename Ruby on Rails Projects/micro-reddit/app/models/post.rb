class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title , presence: true, length: { maximum: 20  }
  validates :text  , presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
end

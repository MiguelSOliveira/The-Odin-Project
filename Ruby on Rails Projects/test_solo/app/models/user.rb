class User < ActiveRecord::Base
  validates :email, presence: true, length: {minimum: 5, maximum: 25}
  validates :name, presence: true, length: {minimum: 5, maximum: 25}
end

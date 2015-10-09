class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
end

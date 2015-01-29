class User < ActiveRecord::Base
  has_many :posts, foreign_key: :creator_id
  has_many :comments, foreign_key: :user_id

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password, presence: true, on: :create
end

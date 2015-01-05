class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :comment, foreign_key: :post_id
end

class Comment < ActiveRecord::Base
  include VoteablePeter
  belongs_to :user, foreign_key: :user_id
  belongs_to :post, foreign_key: :post_id
  has_many :votes, as: :voteable
  validates :body, presence: true
end

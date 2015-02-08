class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :comments 
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  validates :url, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size 
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def user_voted?
    self.votes.where(user_id: current_user.id).present?
  end
end

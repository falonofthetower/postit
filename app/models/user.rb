class User < ActiveRecord::Base
  before_save :create_slug
  has_many :posts, foreign_key: :creator_id
  has_many :comments, foreign_key: :user_id
  has_many :votes, foreign_key: :user_id

  has_secure_password 
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password, presence: true, on: :create

  def already_voted?(object)
    !object.votes.where(creator: self).present?
  end

  def to_param
    slug
  end

  def create_slug
    self.slug = self.username.parameterize
  end
end

class Post < ActiveRecord::Base
  include Sluggable
  include VoteablePeter

  sluggable_column :title

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :url, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }

end

class Category < ActiveRecord::Base
  before_save :create_slug
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  def to_param
    slug
  end

  def create_slug
    self.slug = self.name.parameterize
  end
end

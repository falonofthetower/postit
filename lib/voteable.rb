module Voteable
  extend ActiveSupport::Concern
  has_many :votes, as: :voteable

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

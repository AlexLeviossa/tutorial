module SharedMethods
  extend ActiveSupport::Concern

  def author?(user)
    self.user == user
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
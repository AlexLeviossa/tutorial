module SharedMethods
  extend ActiveSupport::Concern

  def author?(user)
    self.user == user
  end
end
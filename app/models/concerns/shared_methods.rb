# frozen_string_literal: true

module SharedMethods
  extend ActiveSupport::Concern

  def author?(user)
    self.user == user
  end

  def score
    get_upvotes.size - get_downvotes.size
  end

  def set_karma(vote, current_user)
    author = user
    current_user_reputation = current_user.karma
    author_reputation = user.karma

    author_point = if self.class.name == 'Example'
                     vote == 'up' ? 2 : -1
                   else
                     vote == 'up' ? 4 : -2
                   end

    author.update_attribute('karma', author_point + author_reputation)
    current_user.update_attribute('karma', current_user_reputation + 1)
  end
end

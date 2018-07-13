module ActivitiesHelper
  def vote_global(instance)
    if params[:vote] == 'up'
      instance.liked_by current_user
    else
      instance.downvote_from current_user
    end
    if instance.vote_registered?
      instance.set_karma(params[:vote], current_user)
      like = params[:vote] == 'up' ? 'voted for your' : 'downvoted your'
      instance.create_activity key: like, owner: current_user, recipient: instance.user
      flash[:notice] = 'Every vote is important!'
    else
      flash[:danger] = 'You cant vote twice!'
    end
  end
end




class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :forbid_selfvote, only: %i[upvote downvote]



  def vote_global(instance)
    if params[:vote] == 'up'
      instance.liked_by current_user
    else
      instance.downvote_from current_user
    end
    if instance.vote_registered?
      instance.set_karma(params[:vote], current_user)
      flash[:notice] = 'Every vote is important!'
    else
      flash[:danger] = 'You cant vote twice!'
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def forbid_selfvote
    if params[:phrase_id]
      resource = Example.find_by(id: params[:id])
    else
      resource = Phrase.friendly.find(params[:id]) rescue nil
    end

    if resource&.user == current_user
      flash[:danger] = 'It is not allowed to vote for yourself!'
      redirect_back(fallback_location: root_path)
    end
  end
end

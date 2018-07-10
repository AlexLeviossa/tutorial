class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(recipient_id: current_user.id)
                      .order('readed, created_at desc')
  end

  def read_all
    PublicActivity::Activity.where(recipient_id: current_user.id).update_all(readed: true)
  end
end

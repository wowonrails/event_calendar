class FollowedUsersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:followed_users) do
    user.followed_users.order(:full_name).page(params[:page])
  end

  def index
  end
end

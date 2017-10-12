class FollowedUsersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:users) do
    user.followed_users.order(:full_name).page(params[:page])
  end

  def index
    render "users/_list", users: users, layout: false
  end
end

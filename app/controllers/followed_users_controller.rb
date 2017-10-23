class FollowedUsersController < ApplicationController
  expose_decorated(:user) { User.find(params[:user_id]) }

  expose_decorated(:users) do
    user.followed_users.order(:full_name).page(params[:page])
  end

  def index
    render "users/_list", users: users, layout: false
  end
end

class OtherUsersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:users) do
    User.unrelated_users_to(user).order(:full_name).page(params[:page])
  end

  def index
    render "users/_list", users: users, layout: false
  end
end

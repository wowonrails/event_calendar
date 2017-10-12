class OtherUsersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def index
    render "users/_list", users: users, layout: false
  end
end

class OtherUsersController < ApplicationController
  expose_decorated(:user) { User.find(params[:user_id]) }

  expose_decorated(:users) do
    User.unrelated_users_to(user).order(:full_name).page(params[:page])
  end

  def index
    render "users/_list", users: users, layout: false
  end
end

class UsersController < ApplicationController
  expose :user
  expose(:other_users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def show
  end
end

class OtherUsersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:other_users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def index
  end
end

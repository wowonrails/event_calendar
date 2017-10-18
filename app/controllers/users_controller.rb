class UsersController < ApplicationController
  expose :user
  expose(:other_users) do
    User.unrelated_users_to(user).order(:full_name).page(params[:page])
  end

  expose(:relationship) do
    current_user.relationships.find_by(followed_id: user.id)
  end

  def show
  end
end

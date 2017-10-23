class UsersController < ApplicationController
  expose_decorated(:user)
  expose_decorated(:users) do
    User.unrelated_users_to(user).order(:full_name).page(params[:page])
  end

  expose(:relationship) do
    current_user.active_relationships.find_by(followed_id: user.id)
  end

  def show
  end
end

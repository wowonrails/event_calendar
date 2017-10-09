class FollowersController < ApplicationController
  expose(:user) { User.find(params[:user_id]) }

  expose(:followers) do
    user.followers.order(:full_name).page(params[:page])
  end

  def index
  end
end

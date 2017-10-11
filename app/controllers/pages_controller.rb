class PagesController < ApplicationController
  expose(:user) { current_user }
  expose(:other_users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def home
  end
end

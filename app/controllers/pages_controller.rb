class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  expose(:user) { current_user }
  expose(:other_users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def home
  end

  def welcome
  end
end

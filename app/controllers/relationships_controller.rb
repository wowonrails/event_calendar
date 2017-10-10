class RelationshipsController < ApplicationController
  expose :relationship
  expose(:user) { User.find(params[:user_id]) }
  expose(:other_users) do
    User.other_users(user).order(:full_name).page(params[:page])
  end

  def create
    self.relationship = current_user.relationships.create!(followed_id: user.id)
  end

  def destroy
    relationship.destroy
  end
end

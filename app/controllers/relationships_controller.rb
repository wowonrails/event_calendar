class RelationshipsController < ApplicationController
  expose :relationship
  expose(:user) { User.find(params[:user_id]) }
  expose(:other_users) do
    User.unrelated_users_to(user).order(:full_name).page(params[:page])
  end

  def create
    self.relationship = current_user.active_relationships.create!(followed_id: user.id)

    respond_with user, location: -> { user_path(user) }
  end

  def destroy
    relationship.destroy

    respond_with user, location: -> { user_path(user) }
  end
end

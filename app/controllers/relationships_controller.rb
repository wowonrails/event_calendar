class RelationshipsController < ApplicationController
  expose(:relationship) { current_user }

  def create
  end

  def destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(
      :title,
      :public
    )
  end
end

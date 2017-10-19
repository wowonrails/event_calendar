class UserPolicy < ApplicationPolicy
  def following?
    user.active_relationships.find_by(followed_id: record.id)
  end

  def it_me?
    user == record
  end
end

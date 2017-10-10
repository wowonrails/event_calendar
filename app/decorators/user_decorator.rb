class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def following?(user)
    object.relationships.find_by(followed_id: user.id)
  end

  def is_it_me?(user)
    object == user
  end
end

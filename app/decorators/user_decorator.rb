class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :followed_users_count, :followers_count, to: :object

  def full_name_with_email
    "#{full_name} (#{email})"
  end
end

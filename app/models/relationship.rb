class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User", counter_cache: :followed_users_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count
end

class User < ApplicationRecord
  paginates_per 20

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  has_many :events, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id",
                           dependent: :destroy

  has_many :followed_users, through: :relationships,
                            source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy

  has_many :followers, through: :reverse_relationships,
                       source: :follower

  def self.unrelated_users_to(user)
    self.where.not(id: user.followed_user_ids)
        .where.not(id: user.follower_ids)
        .where.not(id: user.id)
  end
end

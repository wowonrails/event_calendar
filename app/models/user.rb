class User < ApplicationRecord
  paginates_per 20

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  has_many :events, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :followed_users, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def self.unrelated_users_to(user)
    self.where.not(id: user.followed_user_ids)
        .where.not(id: user.follower_ids)
        .where.not(id: user.id)
  end
end

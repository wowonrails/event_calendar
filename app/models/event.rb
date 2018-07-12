class Event < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :periodicity, in: %i[once day week month year]

  validates :title, :periodicity, :start, :duration, :description, presence: true

  with_options unless: -> { periodicity.once? } do |event|
    event.validates :finish, presence: true
    event.validates_with EventLimitValidator, if: -> { start.present? && finish.present? }
  end

  scope :public_events, (-> { where(social: true) })

  def self.durations
    (0...24).step(0.5).map { |h| ["#{h} hour", h] }.to_h
  end
end

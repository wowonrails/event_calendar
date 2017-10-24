class Event < ApplicationRecord
  extend Enumerize

  DURATION = {
    "0 min": 0.0,
    "30 min": 0.5,
    "1 hour": 1.0,
    "1.5 hour": 1.5,
    "2 hour": 2.0,
    "2.5 hour": 2.5,
    "3 hour": 3.0,
    "3.5 hour": 3.5,
    "4 hour": 4.0,
    "4.5 hour": 4.5,
    "5 hour": 5.0,
    "5.5 hour": 5.5,
    "6 hour": 6.0,
    "6.5 hour": 6.5,
    "7 hour": 7.0,
    "7.5 hour": 7.5,
    "8 hour": 8.0,
    "8.5 hour": 8.5,
    "9 hour": 9.0,
    "9.5 hour": 9.5,
    "10 hour": 10.0,
    "10.5 hour": 10.5,
    "11 hour": 11.0,
    "11.5 hour": 11.5,
    "12 hour": 12.0,
    "12.5 hour": 12.5,
    "13 hour": 13.0,
    "13.5 hour": 13.5,
    "14 hour": 14.0,
    "14.5 hour": 14.5,
    "15 hour": 15.0,
    "15.5 hour": 15.5,
    "16 hour": 16.0,
    "16.5 hour": 16.5,
    "17 hour": 17.0,
    "17.5 hour": 17.5,
    "18 hour": 18.0,
    "18.5 hour": 18.5,
    "19 hour": 19.0,
    "19.5 hour": 19.5,
    "20 hour": 20.0,
    "20.5 hour": 20.5,
    "21 hour": 21.0,
    "21.5 hour": 21.5,
    "22 hour": 22.0,
    "22.5 hour": 22.5,
    "23 hour": 23.0,
    "23.5 hour": 23.5
  }.freeze

  belongs_to :user

  enumerize :periodicity, in: %i[once day week month year]

  validates :title, :periodicity, :start, :duration, :description, presence: true

  with_options unless: -> { periodicity.once? } do |event|
    event.validates :finish, presence: true
    event.validates_with EventLimitValidator, if: -> { start.present? && finish.present? }
  end

  scope :public_events, (-> { where(social: true) })
end

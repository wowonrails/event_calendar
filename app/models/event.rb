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
  }

  belongs_to :user

  enumerize :periodicity, in: [
    :once,
    :day,
    :week,
    :month,
    :year
  ]

  validates :title,
            :periodicity,
            :start,
            :duration,
            :description, presence: true

  validates_with EventLimitValidator

  scope :dependent_future_events, -> (event) {
    where(["title = ? and start > ?", event.title, event.start])
  }

  def recurring_event!
    unless periodicity == "once"
      number_of_repetitions.times do |i|
        duplicate = dup
        duplicate.start = start + (i + 1).send(periodicity)
        duplicate.save
      end
    end
  end

  def update_dependent_future_events(old_event)
    Event.dependent_future_events(old_event).destroy_all
    recurring_event!
  end

  private

  def number_of_repetitions
    numbers = (finish.to_date - start.to_date).to_i

    case periodicity
    when "day"
      numbers

    when "week"
      numbers/7

    when "month"
      numbers/30

    when "year"
      numbers/365
    end
  end
end

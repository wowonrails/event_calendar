class CreateRecurringEvents
  include Interactor

  delegate :event, to: :context

  def call
    return if event.periodicity == "once"

    number_of_repetitions.times do |i|
      duplicate_event(i)
    end
  end

  private

  def duplicate_event(i)
    duplicate = event.dup
    duplicate.start = event.start + (i + 1).public_send(event.periodicity)
    duplicate.save
  end

  def period_of_time
    (event.finish.to_date - event.start.to_date).to_i
  end

  def number_of_repetitions
    case event.periodicity
    when "day"
      period_of_time
    when "week"
      period_of_time / 7
    when "month"
      period_of_time / 30
    when "year"
      period_of_time / 365
    end
  end
end

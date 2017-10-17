class CreateEvents
  include Interactor

  def call
    return if context.event.periodicity == "once"

    number_of_repetitions.times do |i|
      duplicate = context.event.dup
      duplicate.start = context.event.start + (i + 1).send(context.event.periodicity)
      duplicate.save
    end
  end

  private

  def period_of_time
    context.event.finish.to_date - context.event.start.to_date
  end

  def number_of_repetitions
    case context.event.periodicity
    when "day"
      period_of_time.to_i
    when "week"
      period_of_time.to_i / 7
    when "month"
      period_of_time.to_i / 30
    when "year"
      period_of_time.to_i / 365
    end
  end
end

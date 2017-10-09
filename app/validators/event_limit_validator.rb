class EventLimitValidator < ActiveModel::Validator

  REPETITION_PERIOD = {
    day: 182,
    week: 52,
    month: 24,
    year: 5
  }

  def validate(record)
    unless record.periodicity == "once"
      numbers = (record.finish.to_date - record.start.to_date).to_i

      case record.periodicity
      when "day"
        if REPETITION_PERIOD[record.periodicity.to_sym] < numbers
          record.errors.add(:finish, "The period should be no more than six months")
        end
      when "week"
        if REPETITION_PERIOD[record.periodicity.to_sym] < numbers/7
          record.errors.add(:finish, "The period should be no more than one year")
        end

      when "month"
        if REPETITION_PERIOD[record.periodicity.to_sym] < numbers/30
          record.errors.add(:finish, "The period should be no more than two year")
        end

      when "year"
        if REPETITION_PERIOD[record.periodicity.to_sym] < numbers/365
          record.errors.add(:finish, "The period should be no more than five year")
        end
      end
    end
  end
end

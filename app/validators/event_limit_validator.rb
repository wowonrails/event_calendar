class EventLimitValidator < ActiveModel::Validator
  REPETITION_PERIOD = {
    day:   182,  # divider = 1
    week:  52,   # divider = 7
    month: 24,   # divider = 30
    year:  5     # divider = 365
  }.freeze

  ERROR_MESSAGES = {
    blank: "can't be blank",
    day:   "The period should be no more than six months",
    week:  "The period should be no more than one year",
    month: "The period should be no more than two year",
    year:  "The period should be no more than five year"
  }.freeze

  def validate(record)
    return if record.periodicity == "once" || record.start.nil?

    return record.errors.add(:finish, ERROR_MESSAGES[:blank]) if record.finish.nil?

    number_of_days = (record.finish.to_date - record.start.to_date).to_i

    check_periodicity(record, number_of_days)
  end

  private

  def check_periodicity(record, number_of_days)
    case record.periodicity
    when "day"
      add_error_to_record(record, number_of_days, 1)
    when "week"
      add_error_to_record(record, number_of_days, 7)
    when "month"
      add_error_to_record(record, number_of_days, 30)
    when "year"
      add_error_to_record(record, number_of_days, 365)
    end
  end

  def add_error_to_record(record, number_of_days, divider)
    return unless REPETITION_PERIOD[record.periodicity.to_sym] < number_of_days / divider

    record.errors.add(:finish, ERROR_MESSAGES[record.periodicity.to_sym])
  end
end

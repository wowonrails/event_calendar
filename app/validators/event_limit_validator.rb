class EventLimitValidator < ActiveModel::Validator
  REPETITION_PERIOD = {
    day:   182, # six months
    week:  365, # one year
    month: 730, # two year
    year:  1825 # five year
  }.freeze

  ERROR_MESSAGES = {
    day:   "The period should be no more than six months",
    week:  "The period should be no more than one year",
    month: "The period should be no more than two year",
    year:  "The period should be no more than five year"
  }.freeze

  def validate(record)
    number_of_days = (record.finish.to_date - record.start.to_date).to_i

    return unless REPETITION_PERIOD[record.periodicity.to_sym] < number_of_days

    record.errors.add(:finish, ERROR_MESSAGES[record.periodicity.to_sym])
  end
end

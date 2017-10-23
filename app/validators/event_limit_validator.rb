class EventLimitValidator < ActiveModel::Validator
  REPETITION_PERIOD = {
    day:   182, # six months in days
    week:  365, # one year in days
    month: 730, # two year in days
    year:  1825 # five year in days
  }.freeze

  ERROR_MESSAGES = {
    day:   "The period should be no more than six months",
    week:  "The period should be no more than one year",
    month: "The period should be no more than two year",
    year:  "The period should be no more than five year"
  }.freeze

  def validate(record)
    return unless REPETITION_PERIOD[record.periodicity.to_sym] < number_of_days(record)

    record.errors.add(:finish, ERROR_MESSAGES[record.periodicity.to_sym])
  end

  private

  def number_of_days(record)
    (record.finish.to_date - record.start.to_date).to_i
  end
end

require "rails_helper"

describe Event do
  context "#finish" do
    it "if single event" do
      subject = Event.new(periodicity: "once")
      subject.valid?

      expect(subject.errors[:finish]).not_to include("can't be blank")
    end

    it "if recurring event" do
      subject = Event.new(periodicity: "day", start: Time.zone.now)
      subject.valid?

      expect(subject.errors[:finish]).to include("can't be blank")

      subject.finish = Time.zone.now + 5.year
      subject.valid?

      expect(subject.errors[:finish]).to include(EventLimitValidator::ERROR_MESSAGES[subject.periodicity.to_sym])

      subject.periodicity = "week"
      subject.valid?

      expect(subject.errors[:finish]).to include(EventLimitValidator::ERROR_MESSAGES[subject.periodicity.to_sym])

      subject.periodicity = "month"
      subject.valid?

      expect(subject.errors[:finish]).to include(EventLimitValidator::ERROR_MESSAGES[subject.periodicity.to_sym])

      subject.periodicity = "year"
      subject.valid?

      expect(subject.errors[:finish]).to include(EventLimitValidator::ERROR_MESSAGES[subject.periodicity.to_sym])
    end
  end
end

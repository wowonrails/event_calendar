require "rails_helper"

describe Event do
  describe "#finish" do
    context "when single event" do
      scenario "expect that there are no errors" do
        subject = Event.new(periodicity: "once")
        subject.valid?

        expect(subject.errors[:finish]).not_to include("can't be blank")
      end
    end

    context "when recurring event" do
      scenario "expect that there are errors" do
        subject = Event.new(periodicity: "day", start: Time.zone.now)
        subject.valid?

        expect(subject.errors[:finish]).to include("can't be blank")

        subject.finish = Time.zone.now + 5.year
        subject.valid?

        expect(subject.errors[:finish]).to include("The period should be no more than six months")

        subject.periodicity = "week"
        subject.valid?

        expect(subject.errors[:finish]).to include("The period should be no more than one year")

        subject.periodicity = "month"
        subject.valid?

        expect(subject.errors[:finish]).to include("The period should be no more than two year")

        subject.periodicity = "year"
        subject.valid?

        expect(subject.errors[:finish]).to include("The period should be no more than five year")
      end
    end
  end
end

require "rails_helper"

describe CreateRecurringEvents do
  subject(:context) { described_class.call(event: my_event) }
  let(:my_event) { create(:event, user: create(:user)) }

  describe ".call" do
    scenario "does not create recurring events" do
      my_event.update(periodicity: "once")

      expect { context }.not_to change(Event, :count)
    end

    context "when periodicity is not once" do
      scenario "expect that several events are created with a periodicity of a day" do
        finish = my_event.start + 5.days
        my_event.update(periodicity: "day", finish: finish)

        expect { context }.to change(Event, :count).by(+5)
      end

      scenario "expect that several events are created with a periodicity of a week" do
        finish = my_event.start + 5.weeks
        my_event.update(periodicity: "week", finish: finish)

        expect { context }.to change(Event, :count).by(+5)
      end

      scenario "expect that several events are created with a periodicity of a month" do
        finish = my_event.start + 5.months
        my_event.update(periodicity: "month", finish: finish)

        expect { context }.to change(Event, :count).by(+5)
      end

      scenario "expect that several events are created with a periodicity of a year" do
        finish = my_event.start + 4.years

        my_event.update(periodicity: "year", finish: finish)

        expect { context }.to change(Event, :count).by(+4)
      end
    end
  end
end

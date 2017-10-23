require "rails_helper"

describe UpdateRecurringEvents do
  let(:user) { create(:user) }
  let(:beginning_of_the_event) { Time.zone.now }
  let(:end_of_event) { beginning_of_the_event + 1.day }

  let!(:my_event) do
    create(:event,
      user: user,
      periodicity: "day",
      start: beginning_of_the_event,
      finish: end_of_event)
  end

  let!(:my_recuring_event) do
    create(:event,
      user: user,
      title: my_event.title,
      periodicity: "day",
      description: my_event.description,
      start: end_of_event,
      finish: end_of_event)
  end

  describe ".call" do
    scenario "expect that dependent events are updated" do
      Event.find_each do |event|
        expect(event.title).not_to eq("Birthday party")
      end

      old_event = my_event.dup

      my_event.update(title: "Birthday party")

      expect { described_class.call(event: my_event, old_event: old_event) }.not_to change(Event, :count)

      Event.find_each do |event|
        expect(event.title).to eq("Birthday party")
        expect(event.id).not_to eq(my_recuring_event.id)
      end
    end
  end
end

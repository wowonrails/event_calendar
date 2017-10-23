require "rails_helper"

describe EventSerializer do
  let(:event) { build(:event) }
  let(:serializer) { described_class.new(event) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  scenario "has an id that matches" do
    expect(subject["id"]).to eq(event.id)
  end

  scenario "has a title that matches" do
    expect(subject["title"]).to eq(event.title)
  end

  scenario "has a description that matches" do
    expect(subject["description"]).to eq(event.description)
  end

  scenario "has a periodicity that matches" do
    expect(subject["periodicity"]).to eq(event.periodicity)
  end

  scenario "has a start that matches" do
    expect(subject["start"].to_datetime).to eq(event.start)
  end

  scenario "has a end that matches" do
    expect(subject["end"].to_datetime).to eq(event.start + event.duration.hour)
  end
end

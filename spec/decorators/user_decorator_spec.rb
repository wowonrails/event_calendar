require "rails_helper"

describe UserDecorator do
  subject(:user) { described_class.decorate(current_user) }

  let(:current_user) { create(:user) }

  scenario "has a full name with email that matches" do
    expect(user.full_name_with_email).to eq("#{current_user.full_name} (#{current_user.email})")
  end
end

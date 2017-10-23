require "rails_helper"

describe UserDecorator do
  subject(:user) { described_class.decorate(current_user) }

  let(:current_user) { create(:user) }
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }
  let(:user_4) { create(:user) }
  let(:user_5) { create(:user) }

  before do
    create(:relationship, follower: current_user, followed: user_1)
    create(:relationship, follower: current_user, followed: user_2)
    create(:relationship, follower: user_3, followed: current_user)
    create(:relationship, follower: user_4, followed: current_user)
    create(:relationship, follower: user_5, followed: current_user)

    current_user.reload
    user
  end

  scenario "has an id that matches" do
    expect(user.id).to eq(current_user.id)
  end

  scenario "has a full_name that matches" do
    expect(user.full_name).to eq(current_user.full_name)
  end

  scenario "has a email that matches" do
    expect(user.email).to eq(current_user.email)
  end

  scenario "has a followed users count that matches" do
    expect(user.followed_users_count).to eq(current_user.followed_users_count)
  end

  scenario "has a followers count that matches" do
    expect(user.followers_count).to eq(current_user.followers_count)
  end

  scenario "has a full name with email that matches" do
    expect(user.full_name_with_email).to eq("#{current_user.full_name} (#{current_user.email})")
  end
end

# class UserDecorator < ApplicationDecorator
#   delegate :id, :full_name, :email, :followed_users_count, :followers_count, to: :object

#   def full_name_with_email
#     "#{full_name} (#{email})"
#   end
# end

require "rails_helper"

describe UserDecorator do
  let(:subject) { described_class.decorate(current_user) }

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
    subject
  end

  scenario "has an id that matches" do
    expect(subject.id).to eq(current_user.id)
  end

  scenario "has a full_name that matches" do
    expect(subject.full_name).to eq(current_user.full_name)
  end

  scenario "has a email that matches" do
    expect(subject.email).to eq(current_user.email)
  end

  scenario "has a followed users count that matches" do
    expect(subject.followed_users_count).to eq(current_user.followed_users_count)
  end

  scenario "has a followers count that matches" do
    expect(subject.followers_count).to eq(current_user.followers_count)
  end

  scenario "has a full name with email that matches" do
    expect(subject.full_name_with_email).to eq("#{current_user.full_name} (#{current_user.email})")
  end
end

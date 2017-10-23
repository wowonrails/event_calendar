require "rails_helper"

describe UserPolicy do
  subject { described_class.new(current_user, user) }

  let(:current_user) { create(:user) }
  let(:user) { create(:user) }

  context "user does not follow another one" do
    it { is_expected.to forbid_action(:following) }
  end

  context "user follows another one" do
    before do
      create(:relationship, follower: current_user, followed: user)
      current_user.reload
    end

    it { is_expected.to permit_action(:following) }
  end

  context "user is not current_user" do
    it { is_expected.to forbid_action(:it_me) }
  end

  context "user is current_user" do
    let(:user) { current_user }

    it { is_expected.to permit_action(:it_me) }
  end
end

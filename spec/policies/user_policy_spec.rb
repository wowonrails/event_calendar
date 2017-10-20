require "rails_helper"

describe UserPolicy do
  let(:subject) { described_class }

  let(:current_user) { create(:user) }
  let(:user) { create(:user) }

  permissions :following? do
    scenario "denies access if user does not follow another one" do
      expect(subject).not_to permit(current_user, user)
    end

    scenario "grants access if user follows another one" do
      create(:relationship, follower: current_user, followed: user)
      current_user.reload

      expect(subject).to permit(current_user, user)
    end
  end

  permissions :it_me? do
    scenario "denies access if user is not current_user" do
      expect(subject).not_to permit(current_user, user)
    end

    scenario "grants access if user is current_user" do
      expect(subject).to permit(current_user, current_user)
    end
  end
end

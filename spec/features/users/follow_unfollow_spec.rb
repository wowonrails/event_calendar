require "rails_helper"

feature "Follow/unfollow users" do
  include_context "current user signed in"

  let!(:user_one) { create :user }
  let!(:user_two) { create :user }

  let(:events_of_user_one) { create_list(:event, 5, user: user_one, finish: Time.zone.now.next_month) }
  let(:events_of_user_two) { create_list(:event, 5, user: user_two, finish: Time.zone.now.next_week) }

  let(:public_events_of_user_one) { user_one.events.public_events }
  let(:public_events_of_user_two) { user_two.events.public_events }

  let!(:check_event) do
    create(:event,
      user: user_two,
      title: "Birthday party",
      start: Time.zone.now,
      finish: Time.zone.now.next_week,
      social: true)
  end

  let(:private_events_of_user_one) { user_one.events.where(social: false) }
  let(:private_events_of_user_two) { user_two.events.where(social: false) }

  background do
    create(:relationship, follower_id: current_user.id, followed_id: user_two.id)
    visit root_path
  end

  scenario "User can view public events of other users", js: true do
    expect(page).to have_content(user_one.full_name)
    expect(page).to have_content("1 following")

    click_on user_one.full_name

    expect(page).to have_content(user_one.email)
    expect(page).to have_content("If you want to see my public events")

    click_on "Follow"

    expect(page).to have_content("Unfollow")
    expect(page).to have_content("1 followers")

    find(".fc-listYear-button").click

    public_events_of_user_one.each do |event|
      expect(page).to have_content(event.title)
    end

    private_events_of_user_one.each do |event|
      expect(page).not_to have_content(event.title)
    end

    visit root_path

    expect(page).to have_content("2 following")
  end

  scenario "User can unfollow form public events of other users", js: true do
    click_on "1 following"

    expect(page).to have_content(user_two.full_name)

    click_on user_two.full_name

    expect(page).to have_content("Unfollow")

    click_on "Unfollow"

    expect(page).to have_content("Follow")
    expect(page).to have_content(user_two.email)
    expect(page).to have_content("If you want to see my public events")

    visit root_path

    expect(page).to have_content("0 following")
  end

  scenario "User can read public events of other users", js: true do
    click_on "1 following"

    expect(page).to have_content(user_two.full_name)

    click_on user_two.full_name

    expect(page).to have_content(check_event.title)

    find("span", text: check_event.title).trigger("click")

    expect(page).to have_content(check_event.description)
    expect(page).to have_content(check_event.start.strftime("%d-%m-%Y %H:%M"))
    expect(page).not_to have_link("Edit")
    expect(page).not_to have_link("Delete")
  end
end

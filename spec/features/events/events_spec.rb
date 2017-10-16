require "rails_helper"

feature "Manage Events" do
  include_context "current user signed in"

  describe "Creating events", js: true do
    let(:attributes) do
      attributes_for(:event).slice(:title, :start, :description)
    end

    before do
      Timecop.freeze(Time.zone.local(2017))
      visit root_path
      page.evaluate_script("window.calendar.fullCalendar('gotoDate', new Date(2017, 0));")
    end

    after do
      Timecop.return
    end

    scenario "User creates event which is not repeated" do
      click_link "Create Event"

      expect(page).to have_content("To make the event public?")

      within("#js-event-form-new") do
        fill_form_and_submit(:event, :new, attributes.merge(start: attributes[:start].to_s))
      end

      expect(page).to have_content(attributes[:title])
      expect(Event.count).to eq(1)
    end

    scenario "User creates event which repeated one per day" do
      attributes.merge!(start: Time.zone.today.to_s, periodicity: "Day", finish: (Time.zone.today + 1.day).to_s)

      click_link "Create Event"

      expect(page).to have_content("Select the option to repeat the event")

      within("div[role='dialog']") { fill_form_and_submit(:event, :new, attributes) }

      expect(page).to have_content(attributes[:title])

      find(".fc-listYear-button").click

      expect(page).to have_content(attributes[:title], count: 2)
    end

    scenario "User creates event which repeated one per week" do
      attributes.merge!(start: Time.zone.today.to_s, periodicity: "Week", finish: (Time.zone.today + 1.week).to_s)

      click_link "Create Event"

      expect(page).to have_content("Select the option to repeat the event")

      within("div[role='dialog']") { fill_form_and_submit(:event, :new, attributes) }

      expect(page).to have_content(attributes[:title])

      find(".fc-listYear-button").click

      expect(page).to have_content(attributes[:title], count: 2)
    end

    scenario "User creates event which repeated one per month" do
      attributes.merge!(start: Time.zone.today.to_s, periodicity: "Month", finish: (Time.zone.today + 1.month).to_s)

      click_link "Create Event"

      expect(page).to have_content("Select the option to repeat the event")

      within("div[role='dialog']") { fill_form_and_submit(:event, :new, attributes) }

      expect(page).to have_content(attributes[:title])

      find(".fc-listYear-button").click

      expect(page).to have_content(attributes[:title], count: 2)
    end

    scenario "User creates event which repeated one per year" do
      attributes.merge!(start: Time.zone.today.to_s, periodicity: "Year", finish: (Time.zone.today + 1.year).to_s)

      click_link "Create Event"

      expect(page).to have_content("Select the option to repeat the event")

      within("div[role='dialog']") { fill_form_and_submit(:event, :new, attributes) }

      expect(page).to have_content(attributes[:title])

      find(".fc-listYear-button").click

      expect(page).to have_content("2017")
      expect(page).to have_content(attributes[:title], count: 1)

      find(".fc-next-button").click

      expect(page).to have_content("2018")
      expect(page).to have_content(attributes[:title], count: 1)
    end
  end

  describe "Updating and deleting events", js: true do
    let!(:event) do
      create(:event,
        user: current_user,
        periodicity: "once")
    end

    background do
      visit root_path
    end

    scenario "User can update Event" do
      expect(page).to have_content(event.title)
      expect(Event.count).to eq(1)

      find("span", text: event.title).trigger("click")

      within("div[role='dialog']") do
        expect(page).to have_content(event.title)
        expect(page).to have_content(event.description)

        click_on "Edit"

        expect(page).to have_content("Update all dependent future events")

        fill_form_and_submit(:event, :edit, title: "Birthday party")
      end

      expect(page).to have_content("Birthday party")
      expect(Event.count).to eq(1)
    end

    scenario "User can deleting Event" do
      expect(page).to have_content(event.title)
      expect(Event.count).to eq(1)

      find("span", text: event.title).trigger("click")

      within("div[role='dialog']") do
        expect(page).to have_content(event.title)
        expect(page).to have_content(event.description)

        page.accept_confirm { click_on "Delete" }
      end

      expect(page).not_to have_content(event.title)
      expect(Event.count).to eq(0)
    end
  end
end

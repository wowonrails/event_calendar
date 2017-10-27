require "rails_helper"

feature "Landing" do
  scenario "Visitor view 'Welcome' text" do
    visit root_path

    expect(page).to have_content("Welcome to the Calendar of Events.")
    expect(page).to have_content("This application allows you to create personal private and public events,
                                  view public events of other users")
  end
end

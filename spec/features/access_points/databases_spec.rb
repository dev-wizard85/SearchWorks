require "spec_helper"

feature "Databases Access Point" do
  before do
    visit databases_path
  end
  scenario "Database Topic facet should be present and uncollapsed" do
    within("#facets") do
      within(".blacklight-db_az_subject") do
        expect(page).to_not have_css(".collapsed")
        expect(page).to have_css(".panel-title", text: "Database topic")
      end
    end
  end
  scenario "database topics should be present" do
    expect(page).to have_css('dt', text: "DATABASE TOPICS:")
    expect(page).to have_css('dd a', text: "Biology")
  end
  scenario "database summaries should be present" do
    expect(page).to have_css('dt', text: "DATABASE SUMMARY:")
    expect(page).to have_css('dd', text: "A summary of the database")
  end
end

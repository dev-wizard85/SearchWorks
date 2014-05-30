require "spec_helper"

feature "Digital Collections Search" do
  before do
    visit root_path
    click_link "Digital collections"
  end
  scenario "should have the filter applied" do
    within(".breadcrumb") do
      expect(page).to have_css('.filterName', text: "Collection Type")
      expect(page).to have_css('.filterValue', text: "Digital Collection")
    end
  end
  scenario "should return results" do
    expect(page).to have_css("#documents .document")
  end
end
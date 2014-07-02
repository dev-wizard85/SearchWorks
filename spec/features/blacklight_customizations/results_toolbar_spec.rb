# encoding: UTF-8

require 'spec_helper'

feature "Results Toolbar", js: true do
  before do
    visit root_path
    first("#q").set ''
    click_button 'search'
  end
  scenario "should have desktop tools visible" do
    within "#sortAndPerPage" do
      within "div.page_links" do
        expect(page).to have_css("a.btn.btn-default.btn-sm.disabled", text: /Previous/, visible: false)
        expect(page).to have_css("span.page_entries.hidden-xs", text: /1 - 10 of \d+/, visible: true)
        expect(page).to have_css("a.btn.btn-default.btn-sm", text: /Next/, visible: true)
      end
      expect(page).to have_css("div#view-type-dropdown a")
      expect(page).to have_css("div#sort-dropdown", text: "Sort by relevance", visible: true)
      expect(page).to have_css("#select_all-dropdown", text: "Select all")
      expect(page).to_not have_css("a", text: /Cite/)
      expect(page).to_not have_css("button", text: /Send/)
    end
  end
  scenario "should have tablet and mobile tools hidden" do
    within "#sortAndPerPage" do
      expect(page).to_not have_css("#search-results-toolbar", visible: true)
    end
  end
end

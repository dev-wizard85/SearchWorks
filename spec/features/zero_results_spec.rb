require 'spec_helper'

feature "Zero results" do
  scenario "should have no results and prompt to search all fields" do
    visit root_url
    fill_in "q", with: "sdfsda"
    select 'Author/Contributor', from: 'search_field'
    click_button 'search'
    within "#content" do
      expect(page).to have_css('li', text: 'Search all fields:')
      expect(page).to have_css('li', text: 'sdfsda')
      expect(page).to have_css('a', text: 'sdfsda')
    end
  end
  scenario "should have no results and show correct link from advanced search", js: true do
    visit blacklight_advanced_search_engine.advanced_search_path
    fill_in "search_title", with: "sdfsda"
    click_button 'advanced-search-submit'
    within "#content" do
      expect(page).to have_css("li", text: I18n.t('blacklight.search.zero_results.check_spelling'))
      expect(page).to have_css("a", text: I18n.t('blacklight.search.zero_results.return_to_advanced_search'))
    end
  end
  scenario "should have no results and prompt to remove limit" do
    visit root_url
    click_link "Book"
    fill_in "q", with: "sdfsda"
    click_button 'search'
    within "#content" do
      expect(page).to have_css('li', text: 'Remove limit(s)')
      expect(page).to have_css('li', text: 'All fields > sdfsda')
      expect(page).to have_css('a', text: 'All fields > sdfsda')
    end
  end

  context 'it does not replace query string in a way that will execute js', js: true do
    before { stub_article_service(docs: StubArticleService::SAMPLE_RESULTS) }

    scenario do
      expect do
        accept_alert do
          visit '/?f[building_facet][]=Engineering (Terman)&search_field=title&q=><script>alert%28"BAD%20JS"%29<%2Fscript>'
        end
      end.to raise_error(Capybara::ModalNotFound)
    end
  end

  context 'article search' do
    before { stub_article_service(docs: []) }

    scenario 'displays backend lookup links', js: true do
      visit articles_path(q: 'Kittens', f: { 'eds_facet' => ['Abc'] }, search_field: 'search')

      # Has zero results because we pass an empty array of docs, but is sucessfully searching
      expect(page).to have_link('All fields > Kittens finds 0 results', href: %r{.*/articles\?q=Kittens})
    end
  end
end

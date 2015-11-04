require 'spec_helper'

describe 'Bookplates' do
  describe 'on the record view' do
    it 'displays bookplate data when present' do
      visit catalog_path('45')

      expect(page).to have_css('h2', text: 'Bookplate')
      expect(page).to have_css('.bookplate', count: 2)

      within(first('.bookplate')) do
        expect(page).to have_css('.media-left img')
        expect(page).to have_css('.media-body a', text: 'Susan and Ruth Sharp Fund')
      end

      within(all('.bookplate').last) do
        expect(page).to have_css('.media-left img')
        expect(page).to have_css('.media-body a', text: 'The Edgar Amos Boyles Centennial Book Fund')
      end
    end

    it 'does not include the section when there is no bookplate data' do
      visit catalog_path('44')

      expect(page).not_to have_css('h2', text: 'Bookplate')
      expect(page).not_to have_css('.bookplate')
    end
  end

  describe 'search results' do
    let(:masthead_text) { 'Bookplates honor donors who have created and sustained acquisition funds' }
    it 'displays a masthead with the bookplate data for each individual fund (with correct breadcrumb)' do
      visit catalog_path('45')

      click_link 'Susan and Ruth Sharp Fund'

      within('.bookplate-fund-masthead') do
        expect(page).to have_css('img')
        expect(page).to have_css('h1', text: 'Susan and Ruth Sharp Fund')
        expect(page).to have_content masthead_text
      end

      within('.constraint') do
        expect(page).to have_css('.filterName', text: 'Bookplate')
        expect(page).to have_css('.filterValue', text: 'Susan and Ruth Sharp Fund')
      end

      expect(page).to have_css('h2', text: '1 result')

      visit catalog_path('45')

      click_link 'The Edgar Amos Boyles Centennial Book Fund'

      within('.bookplate-fund-masthead') do
        expect(page).to have_css('img')
        expect(page).to have_css('h1', text: 'The Edgar Amos Boyles Centennial Book Fund')
        expect(page).to have_content masthead_text
      end

      within('.constraint') do
        expect(page).to have_css('.filterName', text: 'Bookplate')
        expect(page).to have_css('.filterValue', text: 'The Edgar Amos Boyles Centennial Book Fund')
      end

      expect(page).to have_css('h2', text: '1 result')
    end
  end
end

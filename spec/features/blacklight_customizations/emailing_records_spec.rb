require "spec_helper"

describe "Emailing Records", type: :feature, js: true do
  context 'when a user is not logged in' do
    it 'the are provided a reCAPTCHA challenge' do
      visit solr_document_path('14')

      within('.record-toolbar') do
        within('li.dropdown') do
          click_button 'Send to'
          within('.dropdown-menu') do
            click_link 'email'
          end
        end
      end

      expect(page).to have_css('h1', text: 'Email This', visible: true)

      within('.modal-dialog') do
        expect(page).to have_css('p', text: '(Stanford users can avoid this Captcha by logging in.)')
      end
    end
  end

  context 'when a user is logged in' do
    before { stub_current_user }

    it "should be successful" do
      visit solr_document_path('14')

      within('.record-toolbar') do
        within('li.dropdown') do
          click_button 'Send to'
          within('.dropdown-menu') do
            click_link 'email'
          end
        end
      end

      expect(page).to have_css('h1', text: 'Email This', visible: true)
      expect(URI(find('#email_form')['action']).path).to eq(email_solr_document_path('14'))

      within('.modal-dialog') do
        fill_in 'to', with: 'email@example.com'
        find('button[type="submit"]').click
      end

      expect(page).to have_css('.alert-success', text: 'Email Sent', visible: true)
    end

    context 'article' do
      before { stub_article_service(type: :single, docs: [document]) }
      let(:document) do
        SolrDocument.new(
          id: '123',
          eds_title: 'The title',
          eds_abstract: 'The Abstract',
          eds_subjects_person: '<searchLink fieldCode="SU" term="Person1">Person1</searchLink><br/><searchLink fieldCode="SU" term="Person2">Person2</searchLink>',
          eds_volume: 'The Volumne'
        )
      end

      it 'sends a brief record' do
        visit article_path(document[:id])

        within('.record-toolbar') do
          within('li.dropdown') do
            click_button 'Send to'
            within('.dropdown-menu') do
              click_link 'email'
            end
          end
        end

        expect(URI(find('#email_form')['action']).path).to eq(email_articles_path)

        within('.modal-dialog') do
          fill_in 'to', with: 'email@example.com'
          find('button[type="submit"]').click
        end

        expect(page).to have_css('.alert-success', text: 'Email Sent', visible: true)
      end
    end

    context 'emailing a full record' do
      it 'should hide the side-nav-minimap' do
        visit solr_document_path('14')

        within('.record-toolbar') do
          within('li.dropdown') do
            click_button 'Send to'
            within('.dropdown-menu') do
              click_link 'email'
            end
          end
        end

        within('.modal-dialog') do
          fill_in 'to', with: 'email@example.com'
          find('#type_full').click

          find('button[type="submit"]').click
        end

        # triggers capybara to wait until email is sent
        expect(page).to have_css('.alert-success', text: 'Email Sent', visible: true)

        body = Capybara.string(ActionMailer::Base.deliveries.last.body.to_s)

        expect(page).to have_css('.side-nav-minimap', visible: false)
      end
    end
  end
end

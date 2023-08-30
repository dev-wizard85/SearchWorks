require "spec_helper"

RSpec.describe "catalog/_index_location" do
  include MarcMetadataFixtures
  describe "accessibility" do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 123' }
          ]
        )
      )
      render
    end

    it "should have a caption" do
      expect(rendered).to have_css('caption.sr-only', text: 'Status of items at Green Library')
    end
    describe "scope" do
      it "is col on the library name" do
        expect(rendered).to have_css('th[scope="col"]', text: 'Green Library')
      end
      it "is col on the status column" do
        expect(rendered).to have_css('th[scope="col"]', text: 'Status')
      end
      it "is col on the location name" do
        expect(rendered).to have_css('th[scope="col"]', text: 'Stacks')
      end
    end
  end

  describe 'location level requests' do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'GREEN', home_location: 'LOCKED-STK', type: 'STKS-MONO', callnumber: 'ABC 123' }
          ]
        )
      )
      render
    end

    it 'has the request link at the location level' do
      expect(rendered).to have_css('tbody th strong', text: /Locked stacks: Ask at circulation desk/)
      expect(rendered).to have_css('tbody td a', text: "Request")
    end
  end

  describe "status icon" do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'SAL3', home_location: 'STACKS', callnumber: 'ABC 123' }
          ]
        )
      )
      render
    end

    it "includes the status icon" do
      expect(rendered).to have_css('tbody td i.deliver-from-offsite')
    end
  end

  describe "status text" do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 123' },
            { barcode: '321', library: 'SPEC-COLL', home_location: 'STACKS', callnumber: 'ABC 321' }
          ]
        )
      )
      render
    end

    it "should have unknown status text for items we'll be looking up" do
      expect(rendered).to have_css('.status-text', text: 'Unknown')
    end
    it "should have explicit status text for items that we know the status" do
      expect(rendered).to have_css('.status-text', text: 'In-library use')
    end
  end

  describe "multiple items in a location" do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 123' },
            { barcode: '456', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 456' }
          ]
        )
      )
      render
    end

    it "should display the location and items in separate table rows" do
      expect(rendered).to have_css('tbody tr', count: 3)
      expect(rendered).to have_css('tbody tr th', text: "Stacks")
      expect(rendered).to have_css('tbody tr td', text: "ABC 123")
      expect(rendered).to have_css('tbody tr td', text: "ABC 456")
    end
  end

  describe "bound with" do
    before do
      allow(view).to receive(:document).and_return(
        SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '1234', library: 'SAL3', home_location: 'SEE-OTHER', callnumber: 'ABC 123' }
          ],
          marc_json_struct: linked_ckey_fixture
        )
      )
      render
    end

    it "should not display request links for requestable libraries" do
      expect(rendered).not_to have_content("Request")
    end
    it 'displays a link to the full record' do
      expect(rendered).to have_css 'th', text: 'Some records bound together'
      expect(rendered).to have_css 'a[href="/view/123"]', text: 'See full record for details'
    end
  end

  describe "mhld" do
    describe "with matching library/location" do
      before do
        allow(view).to receive(:document).and_return(SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '321', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 123' }
          ],
          mhld_display: ['GREEN -|- STACKS -|- public note -|- library has -|- latest received']
        ))
        render
      end

      it "should include the matched MHLD" do
        expect(rendered).to have_css('tbody tr', count: 2)
        expect(rendered).to have_css('tbody tr th', text: /Stacks.*public note/m)
        expect(rendered).to have_css('tbody tr td', text: "ABC 123")
        expect(rendered).to have_css('tbody tr td', text: "Latest: latest received")
      end
    end

    describe "that has no matching library/location" do
      before do
        allow(view).to receive(:document).and_return(SolrDocument.new(
          id: '123',
          mhld_display: ['GREEN -|- STACKS -|- public note -|- library has -|- latest received']
        ))
        render
      end

      it "should invoke a library block w/ the appropriate mhld data" do
        expect(rendered).to have_css('tbody tr', count: 1)
        expect(rendered).to have_css('tbody tr th', text: /Stacks.*public note/m)
        expect(rendered).to have_css('tbody tr td', text: "Latest: latest received")
      end
    end

    describe "with mhld that only has 'Library has' statement" do
      before do
        allow(view).to receive(:document).and_return(SolrDocument.new(
          id: '123',
          item_display_struct: [
            { barcode: '123', library: 'GREEN', home_location: 'STACKS', callnumber: 'ABC 123' }
          ],
          mhld_display: ['GREEN -|- CURRENTPER -|- -|- library has -|-']
        ))
        render
      end

      it "should not display the location" do
        expect(rendered).to have_css('tbody tr', count: 2)
        expect(rendered).not_to have_content('library has')
        expect(rendered).not_to have_content('Current periodicals')
      end
    end
  end

  describe "request links" do
    describe "location level request links" do
      describe "for multiple items" do
        before do
          allow(view).to receive(:document).and_return(
            SolrDocument.new(
              id: '123',
              item_display_struct: [
                { barcode: '123', library: 'GREEN', home_location: 'LOCKED-STK', callnumber: 'ABC 123' },
                { barcode: '456', library: 'GREEN', home_location: 'LOCKED-STK', current_location: 'ON-ORDER', type: 'STKS-MONO', callnumber: 'ABC 456' }
              ]
            )
          )
          render
        end

        it "should put the request in the row w/ the location (since there will be multiple rows for callnumbers)" do
          expect(rendered).to have_css('tbody td a', text: 'Request')
          expect(rendered).not_to have_css('tbody td[data-item-id] a', text: 'Request')
        end
      end
    end
  end
end

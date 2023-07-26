require 'spec_helper'

RSpec.describe LocationRequestLinkComponent, type: :component do
  include MarcMetadataFixtures

  subject(:component) { described_class.for(document:, library:, location:, items:) }

  let(:document) { SolrDocument.new(id: '12345') }
  let(:library) { 'GREEN' }
  let(:location) { 'LOCKED-STK' }
  let(:items) { [instance_double(Holdings::Item, current_location: instance_double(Holdings::Location, code: nil), circulates?: true, folio_item?: false, document:)] }

  let(:page) { render_inline(component) }

  context 'for libaries/locations that are configured to have request links' do
    let(:library) { 'GREEN' }
    let(:location) { 'LOCKED-STK' }

    it { expect(page).to have_link 'Request', href: 'https://host.example.com/requests/new?item_id=12345&origin=GREEN&origin_location=LOCKED-STK' }
  end

  context 'for libraries that are not configured to have request links' do
    let(:library) { 'CLASSICS' }
    let(:location) { 'LOCKED-STK' }

    it { expect(page).not_to have_link }
  end

  context 'for locations that not configured to have request links' do
    let(:library) { 'GREEN' }
    let(:location) { 'IC-NEWSPAPER' }

    it { expect(page).not_to have_link }
  end

  context 'when none of the items have a circulating type' do
    let(:items) { [instance_double(Holdings::Item, circulates?: false, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).not_to have_link }
  end

  context 'when all items are in a mediated page location' do
    let(:library) { 'ART' }
    let(:location) { 'ARTLCKL' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).to have_link 'Request' }
  end

  context 'when all items are in an Aeon library' do
    let(:library) { 'SPEC-COLL' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).to have_link 'Request via Aeon' }
  end

  context 'when all items are in an Aeon library but not an Aeon location' do
    let(:library) { 'ARS' }
    let(:location) { 'REFERENCE' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).not_to have_link 'Request via Aeon' }
  end

  context 'when all items are in an Aeon library and location' do
    let(:library) { 'ARS' }
    let(:location) { 'RECORDINGS' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).to have_link 'Request via Aeon' }
  end

  context 'when all items match a combination of Aeon location and item type' do
    let(:document) { SolrDocument.new(id: '12345') }
    let(:library) { 'SAL' }
    let(:location) { 'L-PAGE-EA' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, type: 'NH-INHOUSE', current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).to have_link 'Request via Aeon' }
  end

  context 'when items match an Aeon location but have the wrong item type' do
    let(:document) { SolrDocument.new(id: '12345') }
    let(:library) { 'SAL' }
    let(:location) { 'L-PAGE-EA' }
    let(:items) { [instance_double(Holdings::Item, circulates?: false, type: 'NEWSPAPER', current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }

    it { expect(page).not_to have_link 'Request via Aeon' }
  end

  context 'when all items are in a disallowed current location' do
    let(:library) { 'SPEC-COLL' }
    let(:items) { [instance_double(Holdings::Item, circulates?: true, current_location: instance_double(Holdings::Location, code: 'SPEC-INPRO'), folio_item?: false, document:)] }

    it { expect(page).not_to have_link }
  end

  context 'for Hoover Archive items with finding aids' do
    let(:document) do
      SolrDocument.new(
        marc_links_struct: [{ href: "http://oac.cdlib.org/ark:/abc123", finding_aid: true }]
      )
    end
    let(:library) { 'HV-ARCHIVE' }
    let(:location) { 'STACKS' }
    let(:items) { [] }

    it { expect(page).to have_link 'Request via Finding Aid', href: 'http://oac.cdlib.org/ark:/abc123' }
  end

  context 'for Hoover Archive items without finding aids' do
    let(:document) do
      SolrDocument.new
    end
    let(:library) { 'HV-ARCHIVE' }
    let(:location) { 'STACKS' }
    let(:items) { [] }

    it { expect(page).to have_content 'Not available to request' }
  end

  context 'for Hoover Library items' do
    let(:document) { SolrDocument.new(marcxml: metadata1) }
    let(:library) { 'HOOVER' }
    let(:location) { 'STACKS' }

    it { expect(page).to have_link 'Request via Aeon', href: /hoover.aeon.atlas-sys.com/ }

    it 'includes custom tooltip markup' do
      rendered_link = page.css(:a).first
      expect(rendered_link['data-toggle']).to eq 'tooltip'
      expect(rendered_link['data-title']).to start_with 'Requires Aeon signup'
    end
  end

  context 'for Hopkins items' do
    let(:document) do
      SolrDocument.new(item_display: item_display_field)
    end
    let(:library) { 'HOPKINS' }
    let(:location) { 'STACKS' }
    let(:items) { [instance_double(Holdings::Item, circulates?: true, current_location: instance_double(Holdings::Location, code: nil), folio_item?: false, document:)] }
    let(:item_display_field) do
      [
        '361051.. -|- HOPKINS -|- STACKS -|- ...'
      ]
    end

    it { expect(page).to have_link 'Request' }

    context 'when the item is also available via SFX' do
      let(:document) do
        SolrDocument.new(
          item_display: item_display_field,
          marc_links_struct: [{ href: "https://library.stanford.edu", sfx: true }]
        )
      end

      it { expect(page).not_to have_link }
    end

    context 'when the full text is also available' do
      let(:document) do
        SolrDocument.new(
          marc_links_struct: [{ href: "https://library.stanford.edu", fulltext: true }],
          item_display: item_display_field
        )
      end

      it { expect(page).not_to have_link }
    end

    context 'when the item is also available via hathitrust' do
      let(:document) do
        SolrDocument.new(ht_htid_ssim: 'abc123', ht_access_sim: ['allow'], item_display: item_display_field)
      end

      it { expect(page).not_to have_link }
    end

    context 'when the item is also available at another library' do
      let(:item_display_field) do
        [
          '361051.. -|- HOPKINS -|- STACKS -|- ...',
          '361052.. -|- GREEN -|- STACKS -|- ...'
        ]
      end

      let(:document) do
        SolrDocument.new(item_display: item_display_field)
      end

      it { expect(page).not_to have_link }
    end
  end

  context 'for items with a finding aid' do
    let(:document) do
      SolrDocument.new(
        id: '12345',
        marc_links_struct: [{ href: "http://oac.cdlib.org/ark:/abc123", finding_aid: true }]
      )
    end

    context 'when the item is at a library that prefers finding aids for requests' do
      let(:library) { 'SPEC-COLL' }

      # We send patrons to requests first to show them instructions, but ultimately
      # requests then sends them to the finding aid, which links to Aeon. See:
      # https://github.com/sul-dlss/sul-requests/issues/1333
      it { expect(page).to have_link 'Request via Finding Aid', href: 'https://host.example.com/requests/new?item_id=12345&origin=SPEC-COLL&origin_location=LOCKED-STK' }
    end

    context 'when the item is at a library that does not prefer finding aids for requests' do
      let(:library) { 'GREEN' }

      it { expect(page).to have_link 'Request', href: 'https://host.example.com/requests/new?item_id=12345&origin=GREEN&origin_location=LOCKED-STK' }
    end
  end

  context 'for FOLIO items' do
    let(:library) { 'SAL3' }
    let(:location) { 'STACKS' }

    let(:material_type) { Folio::Item::MaterialType.new(id: '1a54b431-2e4f-452d-9cae-9cee66c9a892', name: 'book') }
    let(:loan_type) { Folio::Item::LoanType.new(id: '2b94c631-fca9-4892-a730-03ee529ffe27', name: 'Can circulate') }
    let(:items) { [instance_double(Holdings::Item, folio_item?: true, effective_location:, material_type:, loan_type:, folio_status:)] }
    let(:folio_status) { 'Available' }

    context 'in a pageable location' do
      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            'id' => '1146c4fa-5798-40e1-9b8e-92ee4c9f2ee2',
            'code' => 'SAL3-STACKS',
            'name' => 'SAL3 Stacks',
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              'id' => 'ddd3bce1-9f8f-4448-8d6d-b6c1b3907ba9',
              'code' => 'SAL3',
              'name' => 'Stanford Auxiliary Library 3'
            }
          }
        )
      end

      it { expect(page).to have_link 'Request', href: 'https://host.example.com/requests/new?item_id=12345&origin=SAL3&origin_location=STACKS' }
    end

    context 'in a mediated location' do
      let(:library) { 'SAL3' }
      let(:location) { 'PAGE-MP' }

      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            "id" => "398e87b0-35fb-4f80-bb79-b5f70a9a1bc6",
            "name" => "SAL3 PAGE-MP",
            "code" => "SAL3-PAGE-MP",
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              'id' => 'ddd3bce1-9f8f-4448-8d6d-b6c1b3907ba9',
              'code' => 'SAL3',
              'name' => 'Stanford Auxiliary Library 3'
            }
          }
        )
      end

      it { expect(page).to have_link 'Request', href: 'https://host.example.com/requests/new?item_id=12345&origin=SAL3&origin_location=PAGE-MP' }
    end

    context 'in an Aeon location' do
      let(:library) { 'SPEC-COLL' }
      let(:location) { 'MANUSCRIPT' }

      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            "id" => "891ca554-5109-419a-bd01-d647944a40ea",
            "name" => "Spec Manuscript",
            "code" => "SPEC-MANUSCRIPT",
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              "id" => "5b61a365-6b39-408c-947d-f8861a7ba8ae",
              "name" => "Special Collections",
              "code" => "SPEC-COLL"
            }
          }
        )
      end

      it { expect(page).to have_link 'Request', href: 'https://host.example.com/requests/new?item_id=12345&origin=SPEC-COLL&origin_location=MANUSCRIPT' }
    end

    context 'in an Aeon location with a finding aid' do
      let(:document) do
        SolrDocument.new(
          id: '12345',
          marc_links_struct: [{ href: "http://oac.cdlib.org/ark:/abc123", finding_aid: true }]
        )
      end

      let(:library) { 'SPEC-COLL' }
      let(:location) { 'MANUSCRIPT' }

      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            "id" => "891ca554-5109-419a-bd01-d647944a40ea",
            "name" => "Spec Manuscript",
            "code" => "SPEC-MANUSCRIPT",
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              "id" => "5b61a365-6b39-408c-947d-f8861a7ba8ae",
              "name" => "Special Collections",
              "code" => "SPEC-COLL"
            }
          }
        )
      end

      it { expect(page).to have_link 'Request via Finding Aid', href: 'https://host.example.com/requests/new?item_id=12345&origin=SPEC-COLL&origin_location=MANUSCRIPT' }
    end

    context 'in a non-pageable location' do
      let(:library) { 'GREEN' }
      let(:location) { 'STACKS' }

      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            'id' => '4573e824-9273-4f13-972f-cff7bf504217',
            'code' => 'GRE-STACKS',
            'name' => 'Green Library Stacks',
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              'id' => 'f6b5519e-88d9-413e-924d-9ed96255f72e',
              'code' => 'GREEN',
              'name' => 'Cecil H. Green'
            }
          }
        )
      end

      it { expect(page).not_to have_link 'Request' }
    end

    context 'with special collection item' do
      let(:library) { 'SPEC-COLL' }
      let(:effective_location) do
        Folio::Location.from_dynamic(
          {
            'id' => '271f84ab-47aa-40cc-b8a1-18a992bb6b88',
            'code' => 'SPEC-RARE-BOOKS',
            'name' => 'Special Collections Rare Books Collection',
            'institution' => {
              'id' => '8d433cdd-4e8f-4dc1-aa24-8a4ddb7dc929',
              'code' => 'SU',
              'name' => 'Stanford University'
            },
            'campus' => {
              'id' => 'c365047a-51f2-45ce-8601-e421ca3615c5',
              'code' => 'SUL',
              'name' => 'Stanford Libraries'
            },
            'library' => {
              'id' => 'f6b5519e-88d9-413e-924d-9ed96255f72e',
              'code' => 'GREEN',
              'name' => 'Cecil H. Green'
            }
          }
        )
      end

      context 'with "Missing" status' do
        let(:folio_status) { 'Missing' }

        it { expect(page).not_to have_link }
      end

      context 'with "In process" status' do
        let(:folio_status) { 'In process' }

        it { expect(page).not_to have_link }
      end
    end
  end
end

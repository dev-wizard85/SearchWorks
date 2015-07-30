require "spec_helper"

describe Holdings::Library do
  include Marc856Fixtures
  it "should translate the library code" do
    expect(Holdings::Library.new("GREEN").name).to eq "Green Library"
  end
  describe "#locations" do
    let(:callnumbers) { [
      Holdings::Callnumber.new("barcode -|- library -|- home-loc -|- "),
      Holdings::Callnumber.new("barcode -|- library -|- home-loc2 -|- "),
      Holdings::Callnumber.new("barcode -|- library -|- home-loc -|- ")
    ] }
    let(:sort_callnumbers) { [
      Holdings::Callnumber.new("barcode -|- library -|- TINY -|- "),
      Holdings::Callnumber.new("barcode -|- library -|- STACKS -|- "),
      Holdings::Callnumber.new("barcode -|- library -|- CURRENTPER -|- ")
    ] }
    let(:locations) { Holdings::Library.new("GREEN", nil, callnumbers).locations }
    let(:sort_locations) { Holdings::Library.new("GREEN", nil, sort_callnumbers).locations }
    it "should return an array of Holdings::Locations" do
      expect(locations).to be_a Array
      locations.each do |location|
        expect(location).to be_a Holdings::Location
      end
    end
    it "should group by home location" do
      expect(callnumbers.length).to eq 3
      expect(locations.length).to eq 2
    end
    it "should sort by location code when there is no translation" do
      expect(locations.map(&:code)).to eq ["home-loc", "home-loc2"]
    end
    it "should sort locations alpha by name" do
      expect(sort_locations.map(&:name)).to eq ["Current Periodicals", "Miniature", "Stacks"]
      expect(sort_locations.map(&:code)).to eq ["CURRENTPER", "TINY", "STACKS"]
    end
  end
  describe "#present?" do
    let(:callnumbers) { [
      Holdings::Callnumber.new(""),
      Holdings::Callnumber.new(""),
      Holdings::Callnumber.new("")
    ] }
    let(:library) { Holdings::Library.new("GREEN", nil, callnumbers) }
    it "should be false when libraries have no item display fields" do
      expect(library).to_not be_present
    end
  end
  describe "#location_level_request?" do
    it "should return true for all libraries that should be requestable at the location level" do
      Constants::REQUEST_LIBS.each do |library|
        expect(Holdings::Library.new(library)).to be_location_level_request
      end
    end
    describe 'HOPKINS' do
      let(:item_display) { "12345 -|- HOPKINS -|- STACKS -|- " }
      let(:callnumbers) { [Holdings::Callnumber.new(item_display)] }
      let(:online_doc) { SolrDocument.new(marcxml: fulltext_856) }
      let(:online_lib) { Holdings::Library.new("HOPKINS", online_doc, callnumbers) }
      let(:single_item_doc) { SolrDocument.new(item_display: [item_display]) }
      let(:not_online_lib) { Holdings::Library.new("HOPKINS", single_item_doc, callnumbers) }
      let(:multi_holdings_doc) { SolrDocument.new(item_display: [item_display, "54321 -|- GREEN -|- STACKS -|- "]) }
      let(:multiple_holding_lib) { Holdings::Library.new("HOPKINS", multi_holdings_doc, callnumbers) }
      let(:non_stacks_lib) do
        Holdings::Library.new(
          'HOPKINS', SolrDocument.new, [Holdings::Callnumber.new('12345 -|- HOPKINS -|- NOT-STACKS -|- ')]
        )
      end
      it 'returns true for materials that are not available online' do
        expect(not_online_lib).to be_location_level_request
      end
      it 'returns false for materials that exist in other libraries' do
        expect(multiple_holding_lib).to_not be_location_level_request
      end
      it 'returns false for materials that are available online' do
        expect(online_lib).to_not be_location_level_request
      end

      it 'returns false for materials that are not in STACKS' do
        expect(non_stacks_lib).to_not be_location_level_request
      end
    end
  end
  describe '#library_instructions' do
    it 'should return instructions for libraries which have them' do
      Constants::LIBRARY_INSTRUCTIONS.each_key do |library|
        expect(Holdings::Library.new(library).library_instructions).to have_key(:heading)
        expect(Holdings::Library.new(library).library_instructions).to have_key(:text)
      end
    end
  end
  describe "zombie" do
    let(:zombie) { Holdings::Library.new("ZOMBIE") }
    it "should be #zombie?" do
      expect(zombie).to be_zombie
    end
    it "should not be a holding library" do
      expect(zombie).to_not be_holding_library
    end
  end
  describe "#mhld" do
    let(:library) {Holdings::Library.new("GREEN")}
    it "should be an accessible attribute" do
      expect(library.mhld).to_not be_present
      library.mhld = "something"
      expect(library.mhld).to be_present
    end
  end
  describe '#as_json' do
    let(:callnumbers) do
      [
        Holdings::Callnumber.new('barcode -|- library -|- home_location -|- current_location -|- type -|- truncated_callnumber -|- shelfkey -|- reverse_shelfkey -|- callnumber -|- full_shelfkey -|- public_note -|- callnumber_type'),
        Holdings::Callnumber.new('barcode2 -|- library -|- home_location2 -|- current_location -|- type -|- truncated_callnumber -|- shelfkey -|- reverse_shelfkey -|- callnumber -|- full_shelfkey -|- public_note -|- callnumber_type'),
        Holdings::Callnumber.new('barcode3 -|- library -|- home_location3 -|- current_location -|- type -|- truncated_callnumber -|- shelfkey -|- reverse_shelfkey -|- callnumber -|- full_shelfkey -|- public_note -|- callnumber_type')
      ]
    end
    let(:as_json) { Holdings::Library.new('GREEN', nil, callnumbers).as_json }
    it 'should return a hash with all of the libraries public reader methods' do
      expect(as_json).to be_a Hash
      expect(as_json[:code]).to eq 'GREEN'
      expect(as_json[:name]).to eq 'Green Library'
      expect(as_json[:holding_library?]).to be_true
    end
    it 'shuold return an array of locations' do
      expect(as_json[:locations]).to be_a Array
      expect(as_json[:locations].length).to eq 3
      expect(as_json[:locations].first).to be_a Hash
      expect(as_json[:locations].first[:code]).to eq 'home_location'
    end
  end
end

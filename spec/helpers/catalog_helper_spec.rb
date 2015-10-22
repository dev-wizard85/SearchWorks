require 'spec_helper'

describe CatalogHelper do
  describe 'current_view' do
    it 'if params[:view] present, should return it' do
      params = { view: 'gallery' }
      helper.stub(:params).and_return(params)
      expect(helper.current_view).to eq 'gallery'
    end
    it 'if params is not present, return list' do
      expect(helper.current_view).to eq 'list'
    end
  end

  describe '#location_level_request_link?' do
    let(:non_request) { double(reserve_location?: false, location_level_request?: false) }
    let(:reserve_location) { double(reserve_location?: true) }
    let(:location_level_request) { double(reserve_location?: false, location_level_request?: true) }

    it 'is false when the location ends in -RESV' do
      expect(location_level_request_link?(non_request, reserve_location)).to be false
    end

    it 'is false when the library and location are not location level requests' do
      expect(location_level_request_link?(non_request, non_request)).to be false
    end

    it 'is true when the library is a location level request library' do
      expect(location_level_request_link?(location_level_request, non_request)).to be true
    end

    it 'is true when the location is a location level request location' do
      expect(location_level_request_link?(non_request, location_level_request)).to be true
    end
  end
end

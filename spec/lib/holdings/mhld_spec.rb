require 'spec_helper'

describe Holdings::MHLD do
  let(:mhld_display) { 'GREEN -|- STACKS -|- mhld public note -|- mhld library has -|- mhld latest received' }
  let(:special_mhld) { 'GREEN -|- STACKS -|- (public),(note) -|- library-has-with-hyphens and <html> entities -|- ' }
  let(:zombie_mhld) { 'PHYSICS -|- STACKS -|- mhld public note -|- mhld library has -|- mhld latest received' }

  it 'should return the correct elements from the MHLD combined field' do
    mhld = Holdings::MHLD.new(mhld_display)
    expect(mhld.library).to eq 'GREEN'
    expect(mhld.location).to eq 'STACKS'
    expect(mhld.public_note).to eq 'mhld public note'
    expect(mhld.library_has).to eq 'mhld library has'
    expect(mhld.latest_received).to eq 'mhld latest received'
  end

  it 'should escape HTML enteties in MHLD data' do
    library_has = Holdings::MHLD.new(special_mhld).library_has
    expect(library_has).not_to include('<html>')
    expect(library_has).to include('&lt;html&gt;')
  end

  it "should replace '),(' with '), ('" do
    expect(Holdings::MHLD.new(special_mhld).public_note).to match(/\), \(/)
  end

  it 'should append <wbr/> to hyphens' do
    expect(Holdings::MHLD.new(special_mhld).library_has).to include('-<wbr/>')
  end

  it 'should include mhlds from zombie libraries' do
    zombie = Holdings::MHLD.new(zombie_mhld)
    expect(zombie).to be_present
    expect(zombie.library).to eq 'ZOMBIE'
    expect(Holdings::MHLD.new(mhld_display).library).to eq 'GREEN'
  end

  describe '#present?' do
    let(:no_mhld) { 'GREEN -|- STACKS -|- -|- -|-' }
    let(:mhld) { 'GREEN -|- STACKS -|- -|- -|- something' }

    it 'should be false unless a piece of the mhld statement is available' do
      expect(Holdings::MHLD.new(no_mhld)).to_not be_present
    end

    it 'should be true of any piece of the mhld is available' do
      expect(Holdings::MHLD.new(mhld)).to be_present
    end
  end

  describe '#as_json' do
    let(:as_json) { Holdings::MHLD.new(mhld_display).as_json }

    it 'should return a json hash' do
      expect(as_json).to be_a Hash
      expect(as_json[:library]).to eq 'GREEN'
      expect(as_json[:location]).to eq 'STACKS'
      expect(as_json[:library_has]).to eq 'mhld library has'
      expect(as_json[:present?]).to be true
    end
  end
end

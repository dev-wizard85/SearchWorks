require "spec_helper"

describe Holdings::Status do
  let(:status) { Holdings::Status.new(OpenStruct.new) }
  describe "::Available" do
    before do
      Holdings::Status::Available.any_instance.stub(:available?).and_return(true)
    end
    it "should have the available class" do
      expect(status.availability_class).to eq 'available'
    end
    it "should have the available status text" do
      expect(status.status_text).to eq 'Available'
    end
    it "should be available" do
      expect(status).to be_available
    end
  end
  describe "::Noncirc" do
    before do
      Holdings::Status::Noncirc.any_instance.stub(:noncirc?).and_return(true)
    end
    it "should have the noncirc class" do
      expect(status.availability_class).to eq 'noncirc'
    end
    it "should have the noncirc status text" do
      expect(status.status_text).to eq 'In-library use'
    end
    it "should be noncirc" do
      expect(status).to be_noncirc
    end
  end
  describe "::NoncircPage" do
    before do
      Holdings::Status::NoncircPage.any_instance.stub(:noncirc_page?).and_return(true)
    end
    it "should have the noncirc_page class" do
      expect(status.availability_class).to eq 'noncirc_page'
    end
    it "should have the noncirc_page status text" do
      expect(status.status_text).to eq 'In-library use'
    end
    it "should be noncirc_page" do
      expect(status).to be_noncirc_page
    end
  end
  describe "::Pageable" do
    before do
      Holdings::Status::Pageable.any_instance.stub(:pageable?).and_return(true)
    end
    it "should have the page class" do
      expect(status.availability_class).to eq 'page'
    end
    it "should have the page status text" do
      expect(status.status_text).to eq 'Available'
    end
    it "should be pageable" do
      expect(status).to be_pageable
    end
  end
  describe "::Unavailable" do
    before do
      Holdings::Status::Unavailable.any_instance.stub(:unavailable?).and_return(true)
    end
    it "should have the unavailable class" do
      expect(status.availability_class).to eq 'unavailable'
    end
    it "should have the unavailable status text" do
      expect(status.status_text).to eq 'Unavailable'
    end
    it "should be unavailable" do
      expect(status).to be_unavailable
    end
  end
  describe "::Unknown" do
    before do
      Holdings::Status::Unknown.any_instance.stub(:unknown?).and_return(true)
    end
    it "should have the unavailable class" do
      expect(status.availability_class).to eq 'unknown'
    end
    it "should have the unknown status text" do
      expect(status.status_text).to eq 'Unknown'
    end
    it "should be unavailable" do
      expect(status).to be_unknown
    end
  end
  describe "unknown" do
    it "should default to an unknown availability class" do
      expect(status.availability_class).to eq 'unknown'
    end
  end
  describe '#as_json' do
    let(:as_json) { status.as_json }
    it 'should return a json hash with the availability class and status text' do
      expect(as_json).to have_key :availability_class
      expect(as_json).to have_key :status_text
    end
  end
end

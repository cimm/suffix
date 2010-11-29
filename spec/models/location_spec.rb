require 'spec_helper'

describe 'location' do

  it 'does save a location' do
    location = Factory.build(:location)
    location.valid?.should be_true
  end

  it 'is not valid without a label' do
    location = Location.new(:latitude => '51.4967', :longitude => '-0.111807')
    location.valid?.should be_false
    location.errors[:label].include?("can't be blank").should be_true
  end

  it 'is not valid without a latitude' do
    location = Location.new(:label => 'First location', :latitude => '51.4967')
    location.valid?.should be_false
    location.errors[:longitude].include?("can't be blank").should be_true
  end

  it 'is not valid without a longitude' do
    location = Location.new(:label => 'First location', :longitude => '-0.111807')
    location.valid?.should be_false
    location.errors[:latitude].include?("can't be blank").should be_true
  end

  it 'has only one current location' do
    old_location = Factory(:location, :current => true)
    Location.current.should == old_location
    new_location = Factory(:location, :current => true)
    Location.current.should == new_location
    old_location.reload
    old_location.current.should be_false
  end

end

require 'spec_helper'

describe 'photo' do

  describe 'GET index' do

    it 'is hard linked in the navigation' do
      visit '/'
      within 'nav' do
        find_link('photos').visible?.should be_true
      end
    end

    it 'should list a few photos' do # this test needs an internet connection
      visit '/photos'
      find(:id, 'selected').text.strip.should eql 'photos'
      find(:id, 'photos').tag_name.should eql 'ul'
    end

  end

end

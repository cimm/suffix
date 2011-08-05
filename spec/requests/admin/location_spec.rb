require 'spec_helper'

describe 'admin location' do

  before do
    page.driver.browser.basic_authorize('simon', 'secret')
  end

  describe 'GET index' do

    it 'has a list with all locations' do
      locations = 5.times.inject([]) { |locations, index|
        locations << Factory(:location)
      }
      visit '/admin/locations'
      page.should have_content(locations.first.label)
      page.should have_content(locations.last.label)
    end

  end

  describe 'GET/POST new' do

    it 'has a new location form' do
      visit new_admin_location_path
      page.should have_content('New location')
      page.should have_content('Label')
      page.should have_content('Latitude')
      page.should have_content('Longitude')
    end

    it 'adds a new valid location' do
      visit new_admin_location_path
      fill_in 'Label', :with => 'Some location'
      fill_in 'Latitude', :with => '51.4967'
      fill_in 'Longitude', :with => '-0.111807'
      click_button 'Create'
      page.should have_content('Location successfully saved.')
      page.should have_content('Some location')
    end

    it 'adds a new invalid location' do
      visit new_admin_location_path
      fill_in 'Label', :with => 'Some invalid location'
      click_button 'Create'
      page.should have_content('This location could not be saved.')
      page.should_not have_content('Some invalid location')
    end

  end

  describe 'GET/POST update' do

    it 'updates a location' do
      Factory(:location, :label => 'Old location')
      visit admin_locations_path
      click_link 'Edit'
      fill_in 'Label', :with => 'New location'
      click_button 'Update'
      page.should have_content('Location successfully updated.')
      page.should have_content('New location')
      page.should_not have_content('Old location')
    end

  end

end

require 'spec_helper'

describe 'admin tag' do

  before do
    page.driver.basic_authorize('simon', 'secret')
  end

  describe 'GET index' do

    it 'has a list with all tags' do
      tags = 5.times.inject([]) { |tags, index|
        tags << Factory(:tag)
      }
      visit '/admin/tags'
      page.should have_content(tags.first.name)
      page.should have_content(tags.last.name)
    end

  end

  describe 'GET new' do

    it 'has a new tag form' do
      visit new_admin_tag_path
      page.should have_content('New tag')
      page.should have_content('Name')
    end

    it 'adds a new valid tag' do
      visit new_admin_tag_path
      fill_in 'Name', :with => 'Some tag'
      click_button 'Create'
      page.should have_content('Tag successfully saved.')
      page.should have_content('Some tag')
    end

    it 'adds a new invalid tag' do
      visit new_admin_tag_path
      click_button 'Create'
      page.should have_content('This tag could not be saved.')
      page.should_not have_content('Some invalid tag')
    end

  end

  describe 'GET/POST update' do

    it 'updates a tag' do
      Factory(:tag, :name => 'Old tag')
      visit admin_tags_path
      click_link 'Edit'
      fill_in 'Name', :with => 'New tag'
      click_button 'Update'
      page.should have_content('Tag successfully updated.')
      page.should have_content('New tag')
      page.should_not have_content('Old tag')
    end

  end

end

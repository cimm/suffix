require 'spec_helper'

describe 'admin page' do

  before do
    page.driver.basic_authorize('simon', 'secret')
  end

  describe 'GET index' do

    it 'has a list with all pages' do
      pages = 5.times.inject([]) { |pages, index|
        pages << Factory(:page)
      }
      visit '/admin/pages'
      page.should have_content(pages.first.title)
      page.should have_content(pages.last.title)
    end

  end

  describe 'GET new' do

    it 'has a new page form' do
      visit new_admin_page_path
      page.should have_content('New page')
      page.should have_content('Permalink')
      page.should have_content('Content')
    end

    it 'adds a new valid page' do
      visit new_admin_page_path
      fill_in 'Title', :with => 'Some page'
      fill_in 'Permalink', :with => 'some-page'
      fill_in 'Content', :with => 'Some page content.'
      click_button 'Create'
      page.should have_content('Page successfully saved.')
      page.should have_content('Some page')
    end

    it 'adds a new invalid page' do
      visit new_admin_page_path
      fill_in 'Title', :with => 'Some invalid page'
      click_button 'Create'
      page.should have_content('This page could not be saved.')
      page.should_not have_content('Some invalid page')
    end

  end

  describe 'GET/POST update' do

    it 'updates a page' do
      Factory(:page, :title => 'Old page')
      visit admin_pages_path
      click_link 'Edit'
      fill_in 'Title', :with => 'New page'
      click_button 'Update'
      page.should have_content('Page successfully updated.')
      page.should have_content('New page')
      page.should_not have_content('Old page')
    end

  end

end

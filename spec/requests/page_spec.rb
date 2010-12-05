require 'spec_helper'

describe 'page' do

  describe 'GET show' do

    it 'is addressable via its permalink' do
      Factory(:page, :permalink => 'some-page')
      visit '/some-page'
      page.status_code.should eql 200
    end

    it 'is visible in the navigation when flagged as such' do
      page_in_nav = Factory(:page, :in_navigation => true)
      visit '/'
      within 'nav' do
        find_link(page_in_nav.title).visible?.should be_true
      end
    end

    it 'links back to the homepage' do
      some_page = Factory(:page)
      visit page_path(some_page)
      click_link 'home'
      current_path.should eql root_path
    end

    it 'shows the page metadata in the sidebar' do
      some_page = Factory(:page)
      visit page_path(some_page)
      within 'aside' do
        page.should have_content('less than a minute')
      end
    end

  end

end

require 'spec_helper'

describe 'page' do

  describe 'GET show' do

    it 'is addressable via its permalink' do
      Factory(:page, :permalink => 'some-page')
      get '/some-page'
      response.should be_success
    end

    it 'is visible in the navigation when flagged as such' do
      page = Factory(:page, :in_navigation => true)
      get page_url(page)
      response.should have_selector('li', :content => page.title, :id => 'selected')
    end

    it 'links back to the homepage' do
      page = Factory(:page)
      get page_url(page)
      click_link 'home'
      response.should render_template('index')
    end

    it 'shows the page metadata' do
      page = Factory(:page)
      get page_url(page)
      response.should have_selector('abbr', :content => 'less than a minute')
    end

  end

end

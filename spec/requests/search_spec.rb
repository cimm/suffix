require 'spec_helper'

describe 'search' do

  describe 'GET show' do

    it 'has a working search form' do
      visit '/'
      fill_in 'q', :with => 'dontfindme'
      click_button 'search'
      page.should have_content('No results for dontfindme')
    end

    it 'uses a GET request for the search form' do
      visit '/'
      fill_in 'q', :with => 'keyword'
      click_button 'search'
      current_url.should match /q=keyword/
    end

    it 'should show a message when nothing found' do
      visit '/search?q=dontfindme'
      page.should have_content('No results for dontfindme')
    end

    it 'should find a keyword in a page' do
      hit_page = Factory(:page, :content => 'A page containing the findme keyword.')
      miss_page = Factory(:page, :content => 'A page not containing the keyword.')
      visit '/search?q=findme'
      page.should have_content(hit_page.title)
      page.should_not have_content(miss_page.title)
    end

    it 'should find a keyword on a post' do
      hit_post = Factory(:post, :message => 'A post containing the findme keyword.')
      miss_post = Factory(:post, :message => 'A post not containing the keyword.')
      visit '/search?q=findme'
      page.should have_content(hit_post.title)
      page.should_not have_content(miss_post.title)
    end

    it 'should return a teapot status for an empty search' do
      visit '/search'
      page.status_code.should eql 418
      visit '/search?q='
      page.status_code.should eql 418
    end

  end

end

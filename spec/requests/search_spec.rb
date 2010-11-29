require 'spec_helper'

describe 'search' do

  describe 'GET show' do

    it 'should show a message when nothing found' do
      get '/search?q=dontfindme'
      response.should have_selector('h2', :content => 'No results for dontfindme')
    end

    it 'should find a keyword in a page' do
      hit_page = Factory(:page, :content => 'A page containing the findme keyword.')
      miss_page = Factory(:page, :content => 'A page not containing the keyword.')
      get '/search?q=findme'
      response.should have_selector('a', :content => hit_page.title)
      response.should_not have_selector('a', :content => miss_page.title)
    end

    it 'should find a keyword on a post' do
      hit_post = Factory(:post, :message => 'A post containing the findme keyword.')
      miss_post = Factory(:post, :message => 'A post not containing the keyword.')
      get '/search?q=findme'
      response.should have_selector('a', :content => hit_post.title)
      response.should_not have_selector('a', :content => miss_post.title)
    end

    it 'should return a teapot status for an empty search' do
      get '/search'
      response.response_code.should == 418
      get '/search?q='
      response.response_code.should == 418
    end

  end

end

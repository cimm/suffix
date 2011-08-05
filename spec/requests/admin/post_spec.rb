require 'spec_helper'

describe 'admin post' do

  before do
    page.driver.browser.basic_authorize('simon', 'secret')
  end

  describe 'GET index' do

    it 'is admin root path' do
      visit '/admin'
      find(:id, 'selected').text.strip.should eql 'posts'
      page.should have_content('Posts')
    end

    it 'has a list with all posts' do
      posts = 5.times.inject([]) { |posts, index|
        posts << Factory(:post)
      }
      visit '/admin/posts'
      page.should have_content(posts.first.title)
      page.should have_content(posts.last.title)
    end

  end

  describe 'GET new' do

    it 'has a new post form' do
      visit new_admin_post_path
      page.should have_content('New post')
      page.should have_content('Permalink')
      page.should have_content('Message')
    end

    it 'adds a new valid post' do
      visit new_admin_post_path
      fill_in 'Title', :with => 'Some post'
      fill_in 'Permalink', :with => 'some-post'
      click_button 'Create'
      page.should have_content('Post successfully saved.')
      page.should have_content('Some post')
    end

    it 'adds a new invalid post' do
      visit new_admin_post_path
      fill_in 'Title', :with => 'Some invalid post'
      click_button 'Create'
      page.should have_content('This post could not be saved.')
      page.should_not have_content('Some invalid post')
    end

  end

  describe 'GET/POST update' do

    it 'updates a post' do
      Factory(:post, :title => 'Old post')
      visit admin_posts_path
      click_link 'Edit'
      fill_in 'Title', :with => 'New post'
      click_button 'Update'
      page.should have_content('Post successfully updated.')
      page.should have_content('New post')
      page.should_not have_content('Old post')
    end

  end

end

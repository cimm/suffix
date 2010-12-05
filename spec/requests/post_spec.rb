require 'spec_helper'

describe 'post' do

  describe 'GET index' do

    it 'contains the titles of the last 20 posts' do
      posts = 21.times.inject([]) { |posts, index|
        posts << Factory(:post, :created_at => Time.now - index.days)
      }
      visit '/blog'
      page.should have_content(posts.first.title)
      page.should_not have_content(posts.last.title)
    end

    it 'has a search box in the sidebar' do
      visit '/blog'
      within 'aside' do
        page.should have_content('Search')
      end
    end

    it 'has an archive page with all posts' do
      posts = 25.times.inject([]) { |posts, index|
        posts << Factory(:post, :created_at => Time.now - index.days) 
      }
      visit '/archive'
      page.should have_content(posts.last.title)
      page.should have_content(posts.first.title)
    end

  end

  describe 'GET show' do

    it 'is addressable via its permalink' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      visit '/blog/first-post'
      page.should have_content('First post')
    end

    it 'links back to the homepage' do
      post = Factory(:post)
      visit post_path(post)
      click_link 'home'
      current_path.should eql root_path
    end

    it 'shows the post metadata in the sidebar' do
      post = Factory(:post)
      visit post_path(post)
      within 'aside' do
        page.should have_content('less than a minute')
        page.should have_content(post.location.label)
      end
    end

    it 'has a comment form when open for comments in the sidebar' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      visit '/blog/first-post'
      within 'aside' do
        page.should have_content('Something to say?')
        page.should have_content('Content')
      end
    end

    it 'has no comment form in the sidebar when comments are not allowed' do
      Factory(:post, :title => 'First post', :permalink => 'first-post', :comments_open => false)
      visit '/blog/first-post'
      within 'aside' do
        page.should have_content('Something to say?')
        page.should have_content('Comments for this post are closed, you darn spambots.')
      end
    end

    it 'can post a comment when open for comments' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      visit '/blog/first-post'
      fill_in 'Content', :with => 'Some comment on the article.'
      click_button 'Send'
      page.should have_content('Comment successfully saved.')
      page.should have_content('Some comment on the article.')
    end

    it 'shows the total comment count in the sidebar' do
      comment = Factory(:comment)
      visit post_path(comment.post)
      within 'aside' do
        page.should have_content('1 comment')
      end
    end

  end

end

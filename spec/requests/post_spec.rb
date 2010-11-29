require 'spec_helper'

describe 'post' do

  describe 'GET index' do

    it 'contains the titles of the last 20 posts' do
      posts = 21.times.inject([]) { |posts, index|
        posts << Factory(:post, :created_at => Time.now - index.days)
      }
      get '/blog'
      response.should have_selector('h2', :content => posts.first.title)
      response.should_not contain(posts.last.title)
    end

    it 'has a search box' do
      get '/blog'
      response.should have_selector('h2', :content => 'Search')
      response.should have_selector('input')
    end

    it 'has an archive page with all posts' do
      posts = 25.times.inject([]) { |posts, index|
        posts << Factory(:post, :created_at => Time.now - index.days) 
      }
      get '/archive'
      response.should have_selector('a', :content => posts.last.title)
      response.should have_selector('a', :content => posts.first.title)
    end

  end

  describe 'GET show' do

    it 'is addressable via its permalink' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      get '/blog/first-post'
      response.should have_selector('h2', :content => 'First post')
    end

    it 'links back to the homepage' do
      post = Factory(:post)
      get post_url(post)
      click_link 'home'
      response.should render_template('index')
    end

    it 'shows the post metadata' do
      post = Factory(:post)
      get post_url(post)
      response.should have_selector('abbr', :content => 'less than a minute')
      response.should have_selector('abbr', :content => post.location.label)
    end

    it 'has a comment form when open for comments' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      get '/blog/first-post'
      response.should have_selector('h2', :content => 'Something to say?')
      response.should have_selector('label', :content => 'Content')
    end

    it 'has no comment form when comments are not allowed' do
      Factory(:post, :title => 'First post', :permalink => 'first-post', :comments_open => false)
      get '/blog/first-post'
      response.should have_selector('h2', :content => 'Something to say?')
      response.should have_selector('p', :content => 'Comments for this post are closed, you darn spambots.')
    end

    it 'can post a comment when open for comments' do
      Factory(:post, :title => 'First post', :permalink => 'first-post')
      get '/blog/first-post'
      fill_in 'Content', :with => 'Some comment on the article.'
      click_button 'Send'
      response.should have_selector('div', :content => 'Comment successfully saved.')
      response.should have_selector('p', :content => 'Some comment on the article.')
    end

    it 'shows the total comment count' do
      comment = Factory(:comment)
      get post_url(comment.post)
      response.should have_selector('h2', :content => '1 comment')
    end

  end

end

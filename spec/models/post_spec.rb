require 'spec_helper'

describe 'post' do

  it 'does save with a title and a permalink' do
    post = Post.new(:title => 'First post title', :permalink => 'first-post-title')
    post.should be_valid
  end

  it 'is not valid without a permalink' do
    post = Post.new(:title => 'First post title')
    post.should_not be_valid
    post.errors[:permalink].include?("can't be blank").should be_true
  end

  it 'returns the permalink when calling to_param' do
    post = Factory.build(:post, :title => 'First post title', :permalink => 'first-post-title')
    post.to_param.should == 'first-post-title'
  end

  it 'can not have a permalink with spaces' do
    post = Factory.build(:post, :title => 'First post', :permalink => 'first post')
    post.should_not be_valid
    post.errors[:permalink].include?('is invalid').should be_true
  end

  it 'knows when it is older than one year' do
    last_year = Time.now - (1.year + 1.day)
    post = Factory(:post, :updated_at => last_year)
    post.old?.should be_true
  end

  it 'returns datetime for the last updated post' do
    some_date = DateTime.parse('2010/01/30')
    Factory(:post, :updated_at => some_date)
    Post.last_update.to_s(:db).should == some_date.to_s(:db)
  end

  it 'finds all posts with the given keyword in the title or message' do
    Factory(:post, :title => 'Title for search')
    Factory(:post, :message => 'Message for search')
    Factory(:post, :title => 'Title without keyword')
    Factory(:post, :message => 'Message without keyword')
    Post.count.should equal(4)
    Post.search('search').count.should == 2
    Post.search('message').count.should == 2
  end

end

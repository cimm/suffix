require 'spec_helper'

describe 'comment' do

  let(:post) { mock_model(Post) }

  it 'saves a comment for a post' do
    post.should_receive(:comments_open?).and_return true
    comment = Comment.new(:content => 'First comment')
    comment.post = post
    comment.should be_valid
  end

  it 'is not valid without contents' do
    post.should_receive(:comments_open?).and_return true
    comment = Comment.new
    comment.post = post
    comment.should_not be_valid
    comment.errors[:content].include?("can't be blank").should be_true
  end

  it 'is not valid without a well formatted URL' do
    post.should_receive(:comments_open?).and_return true
    comment = Comment.new(:content => 'First comment', :url => 'wrong_url')
    comment.post = post
    comment.should_not be_valid
    comment.errors[:url].include?('wrong format').should be_true
  end

  it 'is not valid when the comments for the post are closed' do
    post.should_receive(:comments_open?).and_return false
    comment = Comment.new(:content => 'First comment')
    comment.post = post
    comment.should_not be_valid
    comment.errors[:base].include?('Comments for this post are closed.').should be_true
  end

end

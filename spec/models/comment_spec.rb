require 'spec_helper'

describe 'comment' do

  it 'saves a comment for a post' do
    post = Factory(:post)
    comment = post.comments.build(:content => 'First comment')
    comment.should be_valid
  end

  it 'is not valid without contents' do
    post = Factory(:post)
    comment = post.comments.build
    comment.should_not be_valid
    comment.errors[:content].include?("can't be blank").should be_true
  end

  it 'is not valid without a well formatted URL' do
    post = Factory(:post)
    comment = post.comments.build(:content => 'First comment', :url => 'wrong_url')
    comment.should_not be_valid
    comment.errors[:url].include?('wrong format').should be_true
  end

  it 'is not valid when the comments for the post are closed' do
    post = Factory(:post, :comments_open => false)
    comment = post.comments.build(:content => 'First comment')
    comment.should_not be_valid
    comment.errors[:base].include?('Comments for this post are closed.').should be_true
  end

end

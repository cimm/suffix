require 'spec_helper'

describe 'tagging' do

  it 'belongs to a tag and a post' do
    tagging = Factory(:tagging)
    tagging.post.class.should equal Post
    tagging.tag.class.should equal Tag
  end

  it 'is not valid without a post' do
    post = Factory(:post)
    tagging = Tagging.new(:post => post)
    tagging.should_not be_valid
    tagging.errors[:tag_id].include?("can't be blank")
  end

  it 'is not valid without a tag' do
    tag = Factory(:tag)
    tagging = Tagging.new(:tag => tag)
    tagging.should_not be_valid
    tagging.errors[:post_id].include?("can't be blank")
  end
end

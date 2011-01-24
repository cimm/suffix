require 'spec_helper'

describe 'tagging' do

  it 'belongs to a tag and a post' do
    tagging = Factory.build(:tagging)
    tagging.should respond_to(:post)
    tagging.should respond_to(:tag)
  end

  it 'is not valid without a post' do
    post = mock_model(Post)
    tagging = Tagging.new(:post => post)
    tagging.should_not be_valid
    tagging.errors[:tag_id].include?("can't be blank")
  end

  it 'is not valid without a tag' do
    tag = mock_model(Tag)
    tagging = Tagging.new(:tag => tag)
    tagging.should_not be_valid
    tagging.errors[:post_id].include?("can't be blank")
  end

end

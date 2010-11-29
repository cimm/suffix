require 'spec_helper'

describe 'tag' do

  it 'saves a tag with a name' do
    tag = Tag.new(:name => 'First tag')
    tag.should be_valid
  end

  it 'is not valid without a name' do
    tag = Tag.new
    tag.should_not be_valid
    tag.errors[:name].include?("can't be blank").should be_true
  end

  it 'can not be longer as 50 characters' do
    tag = Tag.new(:name => 'A long tag name that is longer as the maximum allowed 50 characters')
    tag.should_not be_valid
    tag.errors[:name].include?('is too long (maximum is 50 characters)').should be_true
  end

  it 'returns the tag name when calling to string' do
    tag = Factory.build(:tag)
    tag.name.should == tag.to_s
  end

  it 'has many posts through taggings' do
    tag = Factory.build(:tag)
    tag.posts.first.class.should equal Post
  end

end

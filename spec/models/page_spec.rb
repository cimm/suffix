require 'spec_helper'

describe 'page' do

  it 'saves with a title and a permalink' do
    page = Page.new(:title => 'First page', :permalink => 'first-page')
    page.should be_valid
  end

  it 'is not valid without a permalink' do
    page = Page.new(:title => 'First page')
    page.should_not be_valid
    page.errors[:permalink].include?("can't be blank").should be_true
  end

  it 'returns the permalink when calling to_param' do
    page = Factory.build(:page, :title => 'First page', :permalink => 'first-page')
    page.to_param.should == 'first-page'
  end

  it 'can not have a permalink with spaces' do
    page = Factory.build(:page, :title => 'First page', :permalink => 'first page')
    page.should_not be_valid
    page.errors[:permalink].include?('is invalid').should be_true
  end

  it 'returns datetime for the last updated page' do
    some_date = DateTime.parse('2010/01/30')
    Factory(:page, :updated_at => some_date)
    Page.last_update.to_s(:db).should == some_date.to_s(:db)
  end

  it 'finds pages with the given keyword in the title or content' do
    Factory(:page, :title => 'Title for search')
    Factory(:page, :content => 'Content for search')
    Factory(:page, :title => 'Title without keyword')
    Factory(:page, :content => 'Content without keyword')
    Page.all.count.should equal(4)
    Page.search('search').count.should == 2
    Page.search('content').count.should == 2
  end

end

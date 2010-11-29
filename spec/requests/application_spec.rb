require 'spec_helper'

describe 'application' do

  it 'contains the site title' do
    get '/'
    response.should have_selector('h1', :content => APP_CONFIG['title'])
  end

  it 'contains the owners name in the footer' do
    get '/'
    response.should have_selector('footer', :content => APP_CONFIG['author'])
  end

  it 'contain the last updated date in the footer' do
    last_update = Time.now 
    Factory(:post, :updated_at => last_update)
    get '/'
    response.should have_selector('footer', :content => last_update.to_date.to_s(:long_ordinal))
  end

  it 'contains a link to the policy page in the footer' do
    get '/'
    response.should have_selector('footer a', :content => 'Some rights reserved')
  end

end

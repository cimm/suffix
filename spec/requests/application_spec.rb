require 'spec_helper'

describe 'application' do

  it 'contains the site title in the header' do
    visit '/'
    within 'header' do
      page.should have_content(APP_CONFIG['title'])
    end
  end

  it 'contains the owners name in the footer' do
    visit '/'
    within 'footer' do
      page.should have_content(APP_CONFIG['author'])
    end
  end

  it 'contains the last updated date in the footer' do
    last_update = Time.now 
    Factory(:post, :updated_at => last_update)
    visit '/'
    within 'footer' do
      page.should have_content(last_update.to_date.to_s(:long_ordinal))
    end
  end

  it 'contains a link to the policy page in the footer' do
    visit '/'
    within 'footer' do
      find_link('Some rights reserved').visible?.should be_true
    end
  end

end

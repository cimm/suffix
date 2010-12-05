require 'spec_helper'

describe 'admin application' do

  it 'should authenticate for admin' do
    page.driver.basic_authorize('simon', 'secret')
    visit '/admin'
    page.status_code.should eql 200
    page.status_code.should_not eql 401
  end

end

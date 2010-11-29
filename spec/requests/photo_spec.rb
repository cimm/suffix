require 'spec_helper'

describe 'photo' do

  it 'is hard linked in the navigation' do
    get '/'
    response.should have_selector('li', :content => 'photos')
  end

  it 'should list a few photos' do
    get '/photos'
    response.should have_selector('li', :content => 'photos', :id => 'selected')
    response.should have_selector('ul', :id => 'photos')
  end

end

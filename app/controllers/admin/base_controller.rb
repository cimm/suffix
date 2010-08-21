class Admin::BaseController < ApplicationController

  before_filter :authenticate_admin

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG['username'] && password == APP_CONFIG['password']
    end
  end

end

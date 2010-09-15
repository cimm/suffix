class PagesController < ApplicationController

  def show
    @page = Page.find_by_permalink(params[:id]) || (render :file => "public/404.html", :status => 404, :layout => nil)
  end

end

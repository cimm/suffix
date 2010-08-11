class PagesController < ApplicationController

  def show
    @page = Page.find_by_permalink(params[:id])
  end

end

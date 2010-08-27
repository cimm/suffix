class SearchesController < ApplicationController

  # TODO Empty search not handled
  def show
    if params[:q]
      @query = params[:q].strip
      @results = Post.search(@query) + Page.search(@query)
    else
      flash[:error] = "No search query found."
      redirect_to root_url
    end
  end

end

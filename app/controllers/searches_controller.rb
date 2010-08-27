class SearchesController < ApplicationController

  # TODO Empty search not handled
  def show
    @query = params[:q]
    if @query
      @query.strip!
      @results = Post.search(@query) + Page.search(@query)
    else
      flash[:error] = "No search query found."
      redirect_to root_url
    end
  end

end

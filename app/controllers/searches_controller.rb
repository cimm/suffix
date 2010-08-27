class SearchesController < ApplicationController

  def show
    @query = params[:q]
    if @query && @query.present?
      @query = @query.strip
      @results = Post.search(@query) + Page.search(@query)
    else
      render :file => "public/418.html", :status => 418, :layout => nil
    end
  end

end

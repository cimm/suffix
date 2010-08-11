class Admin::PagesController < Admin::BaseController

  def index
    @pages = Page.order("title asc")
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Page successfully saved."
      redirect_to admin_pages_url
    else
      flash[:error] = "This page could not be saved."
      render :new
    end
  end

  def edit
    @page = Page.find_by_permalink(params[:id])
  end

  def update
    @page = Page.find_by_permalink(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to admin_pages_url, :notice => "Page successfully updated."
    else
      flash.now[:error] = "Oops, something went wrong, could update this page."
      render :edit
    end
  end

   def destroy
     @page = Page.find_by_permalink(params[:id])
     if @page.destroy
       flash[:notice] = "Page successfully deleted."
     else
       flash[:error] = "Oops, something went wrong, could not delete this page."
     end
     redirect_to admin_pages_url
   end

end

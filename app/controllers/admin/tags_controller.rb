class Admin::TagsController < Admin::BaseController

  def index
    @tags = Tag.order("name asc")
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to admin_tags_url, :notice => "Tag successfully saved."
    else
      flash[:error] = "This tag could not be saved."
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      redirect_to admin_tags_url, :notice => "Tag successfully updated."
    else
      flash.now[:error] = "Oops, something went wrong, could update this tag."
      render :edit
    end
  end

   def destroy
     @tag = Tag.find(params[:id])
     if @tag.destroy
       flash[:notice] = "Tag successfully deleted."
     else
       flash[:error] = "Oops, something went wrong, could not delete this tag."
     end
     redirect_to admin_tags_url
   end

end

class Admin::LocationsController < Admin::BaseController

  def index
    @locations = Location.order("updated_at desc")
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      redirect_to admin_locations_url, :notice => "Location successfully saved."
    else
      flash[:error] = "This location could not be saved."
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      redirect_to admin_locations_url, :notice => "Location successfully updated."
    else
      flash.now[:error] = "Oops, something went wrong, could update this location."
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      flash[:notice] = "Location successfully deleted."
    else
      flash[:error] = "Oops, something went wrong, could not delete this location."
    end
    redirect_to admin_locations_url
  end

end

class SessionsController < ApplicationController

  def new
    flash[:notice] = "You are authenticated so what are you doing here?!" if admin?
  end

  def create
    if params[:session][:password] == "secret" # TODO @config['main']['password']
      session[:admin] = true
      flash[:notice] = "Welcome back, dude!"
    else
      flash[:error] = "Oops, wrong password!"
    end
    redirect_to root_url
  end

  def destroy
    reset_session
    flash[:notice] = "Bye, bye, see you soon!"
    redirect_to root_url
  end

end

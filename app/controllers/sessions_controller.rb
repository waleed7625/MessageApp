class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    flash[:success] = "you have sucessfully logged in"
    redirect_to  root_path
    elsif user && !user.authenticate(params[:session][:password])
    flash.now[:error] = "please enter your password"
    render 'new'
    else  
      flash.now[:error] = "your username or password is not correct please try again"
      render 'new'
    end
  end

  def destroy
   session[:user_id] = nil
  flash[:success] = 'you have sucessfully logged out'
  redirect_to login_path  
  end
end

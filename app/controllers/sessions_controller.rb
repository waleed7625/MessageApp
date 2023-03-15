class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: %i(new create)
  before_action :user_params, only: %i(user_create)
  
  def user_new
    @user = User.new
  end

  def user_create
    @user = User.new(user_params)
    pass = @user.password
    pass_digest = BCrypt::Password.create(pass)
    @user.update(password_digest: pass_digest)
    if @user.valid?
      if @user.save!
        session[:user_id] = @user.id
        flash[:success] = "you have sucessfully sign up and logged"
        redirect_to root_path
      end
    else 
      flash[:error] = @user.errors.full_messages[0]
      render "user_new"
    end
  end

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    flash[:success] = "you have sucessfully logged in"
    redirect_to  root_path
    elsif user && !user.authenticate(params[:session][:password])
      flash.now[:warning] = "your username or password is not correct please try again"
      render 'new'
    elsif !user || !user.authenticate(params[:session][:password])
      flash.now[:error] = "please enter your password and username both"
      render 'new'
    else
      flash.now[:purple] = "something went wrong try again!"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'you have sucessfully logged out'
    redirect_to login_path  
  end

  private

  def user_params
    params.require(:user).permit(:username, :password_digest)
  end

  def logged_in_redirect
    if logged_in?
      flash[:error] = "you are already logged in"
      redirect_to root_path
    end
  end
end

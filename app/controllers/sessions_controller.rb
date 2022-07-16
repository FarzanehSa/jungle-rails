class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # success logic, log them in
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:notice_login] = "Your login info is not correct!"
      redirect_to '/login'
      # failure, render login form
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login' 
  end
end
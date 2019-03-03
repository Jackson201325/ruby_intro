class SessionsController < ApplicationController

  def new

  end

  def create
    #render 'new'
    # debugger
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # debugger
      session[:user_id] = user.id
      flash[:success] = "Log In successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Something went wrong"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully Logged Out"
    redirect_to root_path
  end

  


end
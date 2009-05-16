class AuthenticateController < ApplicationController

  def index
    @user = User.new
  end

  def login
    @user = User.authenticate(params[:user])
    if @user.errors.empty?
      session[:user_id] = @user.id 
      redirect_to :controller => :products
    else
      render :action => :index
    end
  end

  def logout
    reset_session
    @user = User.new
    redirect_to :controller => :authenticate
  end

end

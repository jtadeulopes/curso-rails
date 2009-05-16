class PrivateController < ApplicationController
  before_filter :authorization

  def authorization
    unless session[:user_id]
      #@user = User.new
      #@user.errors.add_to_base("access denied")
      redirect_to :controller => :authenticate, :action => :index
    end
  end
end

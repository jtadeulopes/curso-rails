# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def user_logged?
    session[:user_id]
  end
  def current_user
    User.find(session[:user_id])
  end
end

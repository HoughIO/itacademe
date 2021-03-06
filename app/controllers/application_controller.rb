class ApplicationController < ActionController::Base
  before_action :require_user

  protect_from_forgery

  private
  def require_user
    @user = User.new
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
  def authorize_admin
    if current_user.nil? or current_user.classnumber != "1859"
      redirect_to root_url, alert: "Not authorized"
    end
  end
end

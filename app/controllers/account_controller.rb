class AccountController < ApplicationController
  before_filter :fetch_logged_in_user
	
  def login
			if request.post?
			@current_user = User.find_by_login_and_password(
			params[:login], params[:password])
						unless @current_user.nil?
						session[:user_id] = @current_user.id
						unless session[:return_to].blank?
							redirect_to session[:return_to]
							session[:return_to] = nil
							else
						redirect_to :controller => 'stories'
						end
						end
			end
	end

  def logout
session[:user_id] = @current_user = nil
end
def login_required
	return true if logged_in?
	session[:return_to] = request.request_uri

	redirect_to :controller => "/account", :action => "login" and
	return false
end

protected
		def fetch_logged_in_user
			return if session[:user_id].blank?
			@current_user = User.find_by_id(session[:user_id])
		 end 
		 
		 def logged_in?
			! @current_user.blank?
		end
helper_method :logged_in?
end

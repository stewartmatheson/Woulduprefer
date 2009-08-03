# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '645f18ac9a12fda111d64b687fb5cb7c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :get_login

  private
  def get_login
    if logged_in?
      @login = render_to_string :template => 'users/show', :layout => false, :locals => { :current_user => current_user }
    else
      @login = render_to_string :template => 'sessions/new', :layout => false
    end
  end  
end

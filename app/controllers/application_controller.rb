class ApplicationController < ActionController::API
  include ErrorHelper
  
  def current_user(id)
    @user = User.find(id)
  end
  
end

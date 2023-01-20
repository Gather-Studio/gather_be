class ApplicationController < ActionController::API
  
  def current_user(id)
    @user = User.find(id)
  end
  
end

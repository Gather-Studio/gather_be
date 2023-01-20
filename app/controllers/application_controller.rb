class ApplicationController < ActionController::API
  include ErrorHelper
  include AuthHelper
  include ParamsHelper
  
  def current_user(id)
    @user = User.find(id)
  end
  
end

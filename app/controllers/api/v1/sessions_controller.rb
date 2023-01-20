class Api::V1::SessionsController < ApplicationController 
  include AuthHelper
  include ErrorHelper
  include ParamsHelper 

  # POST /api/v1/sessions
    def create
    email = params[:email].downcase
    user = User.find_by(email: email)
    
    if authenticated(user)
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.format_error(authentication_error), status: 400
    end
  end
end
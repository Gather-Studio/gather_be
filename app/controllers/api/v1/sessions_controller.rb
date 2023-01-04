class Api::V1::SessionsController < ApplicationController 
  include AuthHelper
  include ErrorHelper
  include ParamsHelper 
  before_action :downcase_email_params

  # POST /api/v1/sessions
    def create
    user = User.find_by(email: params[:email])
    if authenticated(user)
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.format_error(authentication_error), status: 400
    end
  end
end
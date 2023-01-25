class Api::V1::SessionsController < ApplicationController 

  # POST /api/v1/sessions
    def create
    email = params[:email].downcase
    user = User.find_by(email: email)
    
    if authenticated(user)
      render json: UserSerializer.new(user), status: 201
    else
      authentication_error
    end
  end

  private
    def authenticated(user)
      user && user.authenticate(params[:password])
    end

end
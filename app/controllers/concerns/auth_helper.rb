  module AuthHelper
    include ErrorHelper
  
    def authenticated(user)
      user && user.authenticate(params[:password])
    end

    def validate_api_key(api_key)
      invalid_api_key and return if api_key == nil
      
      admin = User.find_by(api_key: api_key)
      invalid_api_key if !admin
    end

    def invalid_api_key
      render json: ErrorSerializer.format_error(key_error), status: 401
    end

    
  end 

#eventually would like to implement admin roles, which will also add methods here. 
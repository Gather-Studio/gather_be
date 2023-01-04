  module AuthHelper
  
    def authenticated(user)
      user && user.authenticate(params[:password])
    end

  end 

#eventually would like to implement admin roles, which will also add methods here. 
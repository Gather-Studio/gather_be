module ParamsHelper 
  def downcase_email_params
    params[:email] = user_params[:email].downcase if params[:email]
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
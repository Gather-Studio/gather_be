module ParamsHelper 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end

  def item_params
    params.require(:item).permit(:name, :style, :status, :clay_body, :glazes, :height, :width, :memo,:user_id)
  end
end
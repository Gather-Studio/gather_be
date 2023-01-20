module ParamsHelper 

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def item_params
    params.require(:item).permit(:name, :style, :status, :clay_body, :glazes, :height, :width, :memo,:user_id)
  end
end
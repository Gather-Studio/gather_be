class Api::V1::UsersController < ApplicationController
  before_action only: [:show, :update, :destroy] do
    current_user(params[:id])
  end

  before_action only: [:index, :destroy] do 
    validate_api_key(params[:api_key])
  end

  # GET /api/v1/users - admin only
  def index 
    @users = User.all
    render json: UserSerializer.new(@users), status: :ok
  end

  # GET /api/v1/users/1
  def show
    render json: UserSerializer.new(@user), status: :ok
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render_error(@user)
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user), status: :ok
    else
      render_error(@user)
    end
  end

  # DELETE /api/v1/users/1 - Admin Only
  def destroy
    @user.destroy
    render status: 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end

  def validate_api_key(api_key)
    admin = User.find_by(api_key: api_key)
    api_key_error if api_key == nil || admin == nil
  end
  
end

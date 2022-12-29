class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/v1/users
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
    new_user = user_params 
    new_user[:email] = new_user[:email].downcase 
    @user = User.new(new_user)
    
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

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
    render status: 204
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end

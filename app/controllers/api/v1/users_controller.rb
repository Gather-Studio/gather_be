class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/v1/users
  def index
    @users = User.all
    render json: UsersSerializer.new(@users), status: :ok
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
      error = @user.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user), status: :ok
    else
      error = @user.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
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

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end

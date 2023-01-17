class Api::V1::UserItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_user, only: [:index, :destroy]
  include ErrorHelper

  # GET /api/v1/users/:user_id/items
  def index
    if params[:status]
      @items = @user.items.filter_by_status(params[:status])
    else 
      @items = @user.items
    end 
    render json: ItemSerializer.new(@items), status: :ok
  end

  # GET api/v1/users/:user_id/items/1
  def show
    render json: ItemSerializer.new(@item), status: :ok
  end

  # POST api/v1/users/:user_id/items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      render_error(@item)
    end
  end

  # PATCH/PUT api/v1/users/:user_id/items/1
  def update
    if @item.update(item_update_params)
      render json: ItemSerializer.new(@item), status: :ok
    else
      render_error(@item)
    end
  end

  # DELETE api/v1/users/:user_id/items/1
  def destroy
   if @item.user_id == @user.id
    @item.destroy 
    render status: 204
   else 
    render json: ErrorSerializer.format_error(forbidden_error), status: 403
   end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def set_user 
      @user = User.find(params[:user_id])
    end

    def item_params
      params[:item][:user_id] = params[:user_id].to_i
      params.require(:item).permit(:name, :style, :status, :clay_body, :glazes, :height, :width, :memo, :user_id)
    end

    def item_update_params
      params.require(:item).permit(:name, :style, :status, :clay_body, :glazes, :height, :width, :memo, :user_id)
    end
end

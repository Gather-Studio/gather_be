class Api::V1::UserItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action only: [:index, :destroy] do
    current_user(params[:user_id])
  end

  # GET /api/v1/users/:user_id/items
  def index
    @items = Item.where(nil) # creates an anonymous scope
    @items = @items.filter_by_status(params[:status]) if params[:status].present?
    
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
    if @item.update(item_params)
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
end

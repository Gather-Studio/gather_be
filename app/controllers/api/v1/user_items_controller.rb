class Api::V1::UserItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action only: [:index, :destroy] do
    current_user(params[:user_id])
  end

  # GET /api/v1/users/:user_id/items
  def index
    @items = Item.filter(params.slice(:status, :clay_body, :glaze, :style, :name))
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
    @item.destroy 
    render status: 204
  end

private
  def set_item
    @item = Item.find(params[:id])
  end
end

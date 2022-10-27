class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET api/v1/items
  def index
    @items = Item.all
    render json: ItemSerializer.new(@items), status: :ok
  end

  # GET api/v1/items/1
  def show
    render json: ItemSerializer.new(@item), status: :ok
  end

  # POST api/v1/items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      render_error(@item)
    end
  end

  # PATCH/PUT api/v1/items/1
  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item), status: :ok
    else
      render_error(@item)
    end
  end

  # DELETE api/v1/items/1
  def destroy
    @item.destroy
    render status: 204
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :style, :status, :clay_body, :glazes, :height, :width, :memo, :user_id)
    end
end

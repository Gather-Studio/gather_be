class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /api/v1/items
  def index
    @items = Item.filter(params.slice(:status, :clay_body, :glaze, :style, :name))
    render json: ItemSerializer.new(@items), status: :ok
  end

  # GET /api/v1/items/1
  def show
    render json: ItemSerializer.new(@item), status: :ok
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end
end
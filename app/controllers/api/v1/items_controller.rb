class Api::V1::ItemsController < ApplicationController

  # GET /api/v1/items
  def index
    @items = Item.param_filter(params.slice(:status, :clay_body, :glaze, :style, :name))
    render json: ItemSerializer.new(@items), status: :ok
  end
end

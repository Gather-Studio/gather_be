class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /api/v1/items
  def index
    @items = Item.where(nil)
    @items = @items.filter_by_status(params[:status]) if params[:status]
    @items = @items.filter_by_glaze(params[:glaze]) if params[:glaze]
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

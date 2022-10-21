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

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      error = @item.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item), status: :ok
    else
      error = @item.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    render status: 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :type, :status, :clay_body, :glazes, :height, :width, :memo, :user_id)
    end
end

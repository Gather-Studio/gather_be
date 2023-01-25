class Api::V1::ItemGlazesController < ApplicationController
    before_action :set_item_glaze, only: [:update, :destroy]
    
  def create 
    @item_glaze = ItemGlaze.new(item_glaze_params)

    if @item_glaze.save
      render json: ItemGlazeSerializer.new(@item_glaze), status: :created 
    else
      render_error(@item_glaze)
    end
  end

  def update 
     if @item_glaze.update(item_glaze_update_params)
      render json: ItemGlazeSerializer.new(@item_glaze), status: :ok
    else
      render_error(@item_glaze)
    end
  end

  def destroy
    @item_glaze.destroy 
    render status: 204
  end

  def set_item_glaze
    @item_glaze = ItemGlaze.find(params[:id])
  end

  def item_glaze_params
    params.require(:item_glaze).permit(:item_id, :glaze_id, :layers)
  end
  def item_glaze_update_params
    params.require(:item_glaze).permit(:layers)
  end
end
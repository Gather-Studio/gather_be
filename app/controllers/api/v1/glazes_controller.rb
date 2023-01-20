class Api::V1::GlazesController < ApplicationController
  before_action :set_glaze, only: [:show, :update, :destroy]

  # GET /api/v1/glazes
  def index
    @glazes = Glaze.all

    render json: GlazeSerializer.new(@glazes), status: :ok
  end

  # GET /api/v1/glazes/1
  def show
    render json: GlazeSerializer.new(@glaze), status: :ok
  end

  # POST /api/v1/glazes
  def create
    @glaze = Glaze.new(glaze_params)

    if @glaze.save
      render json: GlazeSerializer.new(@glaze), status: :created
    else
      render_error(@glaze)
    end
  end

  # PATCH/PUT /api/v1/glazes/1
  def update
    if @glaze.update(glaze_params)
      render json: GlazeSerializer.new(@glaze)
    else
       render_error(@glaze)
    end
  end

  # DELETE /api/v1/glazes/1
  def destroy
    @glaze.destroy
    render status: 204
  end

  private
    def set_glaze
      @glaze = Glaze.find(params[:id])
    end

end

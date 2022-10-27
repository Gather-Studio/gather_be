class ApplicationController < ActionController::API

  def render_error(object)
    error = object.errors.full_messages.to_sentence.to_s
    render json: ErrorSerializer.format_error(error), status: :unprocessable_entity

  end
end

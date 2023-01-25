module ErrorHelper 

  def render_error(object)
    error = object.errors.full_messages.to_sentence.to_s
    render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
  end

  def api_key_error
    render json: ErrorSerializer.format_error("Invalid API key."), status: 401
  end
  
  def authentication_error
    render json: ErrorSerializer.format_error("Those credentials are incorrect. Try again!"), status: 400
  end
end
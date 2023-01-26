module ErrorHelper 

  def render_error(object)
    error = object.errors.full_messages.to_sentence.to_s
    serialize_error(error, 422)
  end

  def api_key_error
    serialize_error("Invalid API key.", 401)
  end
  
  def authentication_error
    serialize_error("Those credentials are incorrect. Try again!", 400)
  end
  
  def not_found_error 
    serialize_error("Item not found.", 404)
  end

  def serialize_error(message, status)
    render json: ErrorSerializer.format_error(message), status: status
  end
end
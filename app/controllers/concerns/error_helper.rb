module ErrorHelper 


  def render_error(object)
    error = object.errors.full_messages.to_sentence.to_s
    render json: ErrorSerializer.format_error(error), status: :unprocessable_entity
  end
  
  def authentication_error
    "Those credentials are incorrect. Try again!"
  end

  def forbidden_error
    "Sorry, you do not have access to to do that."
  end
end
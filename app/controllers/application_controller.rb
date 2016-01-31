class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def response_formatter(payload, meta, status)
    render json: {
      payload: payload,
      meta: meta
    }, status: status
  end

end

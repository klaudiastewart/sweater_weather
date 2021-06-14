class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def bad_params_400(message)
    body = ({
      error: "#{message}",
      status: 400
      }).to_json
    render json: JSON.parse(body, :quirks_mode => true), status: 400
  end

  def bad_params_401(message)
    body = ({
      error: "#{message}",
      status: 401
      }).to_json
    render json: JSON.parse(body, :quirks_mode => true), status: 401
  end
end
